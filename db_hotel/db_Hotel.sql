PGDMP         6                x           db_Hotel    12.2    12.2     4           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            5           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            6           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            7           1262    16644    db_Hotel    DATABASE     �   CREATE DATABASE "db_Hotel" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1253' LC_CTYPE = 'English_United States.1253';
    DROP DATABASE "db_Hotel";
                postgres    false            �            1255    16710    false_booking()    FUNCTION     >  CREATE FUNCTION public.false_booking() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.from_date BETWEEN '2020-06-01' AND '2020-06-30' THEN
RAISE NOTICE 'FALSE BOOKING';
UPDATE ROOMS SET price_range='economy', room_cost=room_cost - room_cost*30/100 WHERE price_range='luxury';
END IF;
RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.false_booking();
       public          postgres    false            �            1255    16645    get_visitor(date, date)    FUNCTION     S  CREATE FUNCTION public.get_visitor(var1 date, var2 date) RETURNS TABLE(id_visitor integer, fullname text)
    LANGUAGE plpgsql
    AS $$
DECLARE 
temp record;
cur_visitor cursor(var1 date, var2 date) FOR 
SELECT RESERVATIONS.id_visitor AS visitor, VISITORS.fullname AS name
FROM RESERVATIONS INNER JOIN VISITORS ON (RESERVATIONS.id_visitor = VISITORS.id_visitor) 
WHERE from_date BETWEEN var1 AND var2;
BEGIN 
OPEN cur_visitor(var1, var2);
LOOP
FETCH cur_visitor INTO temp;
EXIT WHEN NOT FOUND;
id_visitor:= temp.visitor;
fullname:= temp.name;
RETURN NEXT;
END LOOP;
CLOSE cur_visitor;
END; $$;
 8   DROP FUNCTION public.get_visitor(var1 date, var2 date);
       public          postgres    false            �            1259    16646 	   customers    TABLE     [  CREATE TABLE public.customers (
    id_customer integer NOT NULL,
    title text NOT NULL,
    fullname text NOT NULL,
    age integer NOT NULL,
    address text NOT NULL,
    postal_code integer NOT NULL,
    city text NOT NULL,
    country text NOT NULL,
    phone_number text NOT NULL,
    email text NOT NULL,
    credit_card text NOT NULL
);
    DROP TABLE public.customers;
       public         heap    postgres    false            �            1259    16834 	   new_rooms    TABLE     `   CREATE TABLE public.new_rooms (
    new_price_range text,
    new_room_cost double precision
);
    DROP TABLE public.new_rooms;
       public         heap    postgres    false            �            1259    16652    reservations    TABLE     (  CREATE TABLE public.reservations (
    id_reservation integer NOT NULL,
    id_customer integer NOT NULL,
    id_visitor integer,
    date date NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    status_cost boolean NOT NULL,
    date_cost date,
    id_room integer NOT NULL
);
     DROP TABLE public.reservations;
       public         heap    postgres    false            �            1259    16655    room_reservations    TABLE     �   CREATE TABLE public.room_reservations (
    id_reservation integer NOT NULL,
    id_customer integer NOT NULL,
    credit_card text NOT NULL,
    total_cost double precision NOT NULL
);
 %   DROP TABLE public.room_reservations;
       public         heap    postgres    false            �            1259    16661    rooms    TABLE       CREATE TABLE public.rooms (
    id_room integer NOT NULL,
    type text NOT NULL,
    price_range text NOT NULL,
    tv boolean NOT NULL,
    air_condition boolean NOT NULL,
    room_service boolean NOT NULL,
    season text NOT NULL,
    room_cost double precision NOT NULL
);
    DROP TABLE public.rooms;
       public         heap    postgres    false            �            1259    16853    updated_rooms    TABLE     �   CREATE TABLE public.updated_rooms (
    id_room integer NOT NULL,
    new_price_range text,
    new_room_cost double precision,
    from_date date
);
 !   DROP TABLE public.updated_rooms;
       public         heap    postgres    false            �            1259    16667    visitors    TABLE     Y  CREATE TABLE public.visitors (
    id_visitor integer NOT NULL,
    title text NOT NULL,
    fullname text NOT NULL,
    age integer NOT NULL,
    address text NOT NULL,
    postal_code integer NOT NULL,
    city text NOT NULL,
    country text NOT NULL,
    phone_number text NOT NULL,
    email text NOT NULL,
    credit_card text NOT NULL
);
    DROP TABLE public.visitors;
       public         heap    postgres    false            +          0    16646 	   customers 
   TABLE DATA           �   COPY public.customers (id_customer, title, fullname, age, address, postal_code, city, country, phone_number, email, credit_card) FROM stdin;
    public          postgres    false    202   ;+       0          0    16834 	   new_rooms 
   TABLE DATA           C   COPY public.new_rooms (new_price_range, new_room_cost) FROM stdin;
    public          postgres    false    207   S�       ,          0    16652    reservations 
   TABLE DATA           �   COPY public.reservations (id_reservation, id_customer, id_visitor, date, from_date, to_date, status_cost, date_cost, id_room) FROM stdin;
    public          postgres    false    203   p�       -          0    16655    room_reservations 
   TABLE DATA           a   COPY public.room_reservations (id_reservation, id_customer, credit_card, total_cost) FROM stdin;
    public          postgres    false    204   6�       .          0    16661    rooms 
   TABLE DATA           o   COPY public.rooms (id_room, type, price_range, tv, air_condition, room_service, season, room_cost) FROM stdin;
    public          postgres    false    205   ��       1          0    16853    updated_rooms 
   TABLE DATA           [   COPY public.updated_rooms (id_room, new_price_range, new_room_cost, from_date) FROM stdin;
    public          postgres    false    208   �       /          0    16667    visitors 
   TABLE DATA           �   COPY public.visitors (id_visitor, title, fullname, age, address, postal_code, city, country, phone_number, email, credit_card) FROM stdin;
    public          postgres    false    206   8�       �
           2606    16674    customers customers_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id_customer);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public            postgres    false    202            �
           2606    16676    reservations reservations_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id_reservation, id_customer, id_room);
 H   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_pkey;
       public            postgres    false    203    203    203            �
           2606    16678 (   room_reservations room_reservations_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.room_reservations
    ADD CONSTRAINT room_reservations_pkey PRIMARY KEY (id_reservation, id_customer);
 R   ALTER TABLE ONLY public.room_reservations DROP CONSTRAINT room_reservations_pkey;
       public            postgres    false    204    204            �
           2606    16680    rooms rooms_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id_room);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public            postgres    false    205            �
           2606    16682    visitors visitors_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id_visitor);
 @   ALTER TABLE ONLY public.visitors DROP CONSTRAINT visitors_pkey;
       public            postgres    false    206            �
           2620    16868    reservations false_booking    TRIGGER     x   CREATE TRIGGER false_booking BEFORE INSERT ON public.reservations FOR EACH ROW EXECUTE FUNCTION public.false_booking();
 3   DROP TRIGGER false_booking ON public.reservations;
       public          postgres    false    210    203            �
           2606    16683 *   reservations reservations_id_customer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public.customers(id_customer);
 T   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_id_customer_fkey;
       public          postgres    false    202    2718    203            �
           2606    16688 9   reservations reservations_id_reservation_id_customer_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_reservation_id_customer_fkey FOREIGN KEY (id_reservation, id_customer) REFERENCES public.room_reservations(id_reservation, id_customer);
 c   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_id_reservation_id_customer_fkey;
       public          postgres    false    203    2722    203    204    204            �
           2606    16693 &   reservations reservations_id_room_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_room_fkey FOREIGN KEY (id_room) REFERENCES public.rooms(id_room);
 P   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_id_room_fkey;
       public          postgres    false    203    2724    205            �
           2606    16698 )   reservations reservations_id_visitor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_id_visitor_fkey FOREIGN KEY (id_visitor) REFERENCES public.visitors(id_visitor);
 S   ALTER TABLE ONLY public.reservations DROP CONSTRAINT reservations_id_visitor_fkey;
       public          postgres    false    203    2726    206            �
           2606    16859 (   updated_rooms updated_rooms_id_room_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.updated_rooms
    ADD CONSTRAINT updated_rooms_id_room_fkey FOREIGN KEY (id_room) REFERENCES public.rooms(id_room);
 R   ALTER TABLE ONLY public.updated_rooms DROP CONSTRAINT updated_rooms_id_room_fkey;
       public          postgres    false    2724    208    205            +      x���ˮ�J�%86}g=���6����z�{�g��DQ�(R�Ǒ�2h�/TN�+�5�����D!�~����Kz-3����
DĽq��L4۶�Z�e�8��i������2}U�E,t��O;����Дu/T$���A|��4"M�2¥����g�r_�GysJ�Q��H�0�e*!�z�Ե�-L��(M��XXD���M��4C���)����ċ�(�BI�L�\&���z;�U�l�z2	��q��p!šϪM[����PtE-�Dh�]Q����u"ڳ9�}w���˴��*ė�R���#��T��q�(�i�h_GQ-�X7yߴ����{U�M/B_$���EE��P�x�+�.k�KL��U�š���v�8�u��Q�??M��_D���
{��E�)�j--�0�?w��=m�;lU(���^�';��H�t�qT~��0�<Te]����Q]<�=
�H�Q����E��ޘ~��>�"����l_�m�����O�p�l�Ҵ��qQ�F|h�~ؚJH|�
�e����p��c�ڴeQ�+��2��$VQ*ұ�H�]}���6��Z$�O<�������^ıx9�z�-�oNb�t��1Ebu�F�ٶi�U�Ə���Oc|�VA����������އ�]c�TQ*�/eU�ma;��������2�Y�+�#�3�K��Q����N�d���Ь����R�N|��_����XvkjK��˦:��v�}�Z��pWޕۡ�ć]Y��cY�9X���bH�m��H�Sw;o��~��(L8?\��Us^{���-;���g�㧦Y��#C,��Y�(��fY�˷�\�筩qe/�ć�Ɖ�tv"�q7�v˯T
?)c?֋ �g�5T.O�-�2���v\w�9��ފ�Ͷ��E�(�tWk;�@Z�6/6X�W��"�BV5���"���iqE�T+E+|P��Oy��އ����oqVEy�k�Qdb,���L�P���_M���~�k�(��r�ۦ�w޳�h�$�+��ڢ�^uޗ�%��*��k=i�氂�DQ���F�4�b�#��Ͱ�S�Z� 	�H>th0k��ú�+��{����s' 퐯��^4պ�����8=�$�c�����|l���)�R�Zi��u��*��Zg놧��CG����Z��R�1A��UIO*lx���][�"Q��z|}�T_(��zhK�����
0H���q����.�ߣ�Uq�8X��\*�G[��
bP���^�{\uy/�ͦ����'e�W��v�(�5��K�$yO�mt($��� ��I��o�7㔛�iM�Cw�V�*M�4��>�%��i��=�W&"�=h˲�`��%�g�����Bq�pӱd��8̥�u � �����Z���@+�Ұ�����/ߡZ�h�4Q���lr�}�a#!끸���dN���	����|Ez)�SŪq�w3�#��ǑTA�����DC�C���R������P��6C�7����������i����,�P�}��C�:�;� Xj?����&+3薢��׾JRi��d�k�6.֩�`Z��E�=7P��6w���R���������2Y&JJaV�\���b=�$c"�@�a��"��/�ga+�oU�TG"�nڽ�;�]N��ջh֍Q�C�����8�>[C9�e3t�q�x�`o�����x�8a�v{���V8��!�1hWUю 	j�����ֈO��:F/lP�&4fn�*;4��_�z�R ���	q��9��h��WJ���p5�E�I��7�m��7k�� ֞�׸��}��J��>nV,� ��lǙY��<�M�����GA t�9D��D1�C�ga����\�ҋ�r ��cQ�C��ѮLyKC���@�>f�p�:˛j�ڵ�%5 I�hQ-B��^7���%~�T�r�J��HA �!�`& �|�T���>��]�܉'�E��>�a��aD,�L|q�q�5�
�ޣ�EJ^L 	��k�.�x���C����To{j�T����q�x/q���TCnN�X�۶��_F�Pq��&8f�a�<�e��~$��Cܺ�^��ȼ���� �%��u��?@�{Ӛe�+a���P3�%��>'��uC{W�M�/��QZ�ҧ�<H%��"�ݧ��PQz_w�G�G�c��`�����l����������.��fh�DǢ;��m6t�o�fƘ>/���b�/%�ƚ��Ĳ�a"�o,T����+>�8p�ǭ��N��e��}����N�e��ӢP�����J��^`��Ҵ����ăQ���Y2������V�ô����+Zc��n��ώE��J+�>�`M�4�� XH�ޞ� ]�=��b���-������wf?m�0��C t"_a����@0Dcј�z�L�<m%r�h75���B���@�:�>��ܷ�L!������W��&K�-��H���$w٪�.��ʜƣ����5��$�9�9��5o3��= `���#�MYwح�/I�Ρ�&-��X�w�v���6�ؓe�N�C� [`:8\���
�6�o�-�H�؜p��>�]啕�E��S�HOg���ǿ����ͩ,rl��2���WR��>��8����N��_{�q�X�������r�j���]���Q���#$��x9hR�	�X�̈�!�K�c�N3Nr�"�8�H����N �rV[�˪� ���	���}2C�k6��R���~�̅=Eq�F�[o��{ �u����6�ǁ$!0K�$������� 	��EvW��P���Q]+�WӴop�ط��T��M��Na%�����Y��?�wX�O�؇%C���0�� !���?@؏���������v�	u�"�L=�� �N�o��%�9T��|*RYH�����=�B�����"T�佱�7�Nt �1����B;K%����rxf�]G�����
�<L�;ʡ1|��cũ+�1s�3�y�D��Mkp_���m��<C�/#mb1N���T�2S����~��-q����q踓�ԉ�yg�=��ّh{d|��!�bLa��(�8LѴv�@o�4���P:�ȭ�%��,�{�b�1p����w��]&!����h� 	n�đ�.�� �6M�/�����
V/Md�J^1�2�#���g�5���\�����.Rh�* $����Wm�ZO�*��M� �
�XY���!}��MU��|O@�ż4�[���<�)=�5�$�m���xp:! ����dA�}osQ�2��%I�*��Ѩ�k��w �����W��i����zw�U4Ţ�	�GJ�v|�f�*w�T��1�&򓅲>�����0�=�0jE�8����DY	,�02Hl'4$�^�3�jP�j�g��g]��R!@��-�.�;5�ζ�	��iQo���U���vš�m7N�l�T��W�I��%|�
G;�/����a�,j�#���af(�7��������(�%��\H�����Sa`��Q���(���W/��� }[����:��&L��&O�+��S:b����0M��%�c7��3mT�\�t�|Hp��UI��L����� +`Ũz�g��|����~�7A�����3��)�u:U��UG����]DV}ڙ3��MU��z[PQ���˃[1$o�K����J�lhL (�`# 
��Gg�Y�";�-�z[��`�퍁"�� *8r.sP������?�/����8`��ŴW���HL@K�O��`�����;���爣ȧ֏(5���K'�$V�A��y���p~_�Ϸ����d ���5N�vk��l�Z�,4�!p8��D,�٩�O���1T�"p
�����%��]���b�V@�W�
��Z�n�j�`����Uq���P�����h�=ƻ���-}r�!���>��� �3�BEe����Mqm� ��9r�bm.�e��-�=� H�0��6��`��j���
�������%G�i)��� �;�b�Yp}@�H䕛 �%.߂� 79��-N5�e�q�A������(��    =����{O��/�0�E+�6�r�S7�h�0Ӣ�L3���X�8�����,\� �뼷?[� ����ʙq��w>�LxI�x	�� �+��7�F.&��%R!h�Z�|:I�#n��{Lc^��R?c�������Sy6;�G�0�_&P��2�����������JP!z�&�͡ta��t{� ����m��HPU��yme�v��d@6"�#���N�٪i�0#c$�Y�`Y�V��r��A����#=�.���D��|u5�A?��W%]� �����N4Y[8�n�h�4�:u�q�\20�:D� ��U��S�6,Ks
T�T�`��R¼�M�j�v�1;��GP��H*� �W.@��]����=�Lw�ߟ�	�&��Tg ��a��ֺ��ߘ���m��!���䡊S�t#�Zeq�F��iE$�L\��z[��;�U0ƀ(��;͎��Q��+��8�y�Mn�Jp���smv6�)Jbp:����l�uM=.��϶g��>��y�1o�5��K�Z��'�®����`	�5=k��$",��g2������}G��������8m����-��,P��R 5�'a���A��xy�1��K�@��s�N�%�W��g��v&X�lg-���r�$�)j���,KZ%V-G�e��,�y�����6��NM� �٩&Lʵp}��q�(q�~U��M�7;S�ǡ��Y��۟w�w�=��t�bnql�邻9|�����*1.�Y[��9�p_7]Qwe9Ǖ��ٯw�����*|p��<(`���<Ap���a�,�)$^kr��_$6���"�����
�k��I�f@k��tUs���F�v �m��Aj�?r��{��#a�l��Oթ�Eb׳��3�z�X�fq����Cޛ���k-@�JUi��MD��)�3��w&?_�#�(>y;�`a�HB�%!ʿ��.���.Z3� }z�M�����7t��<����!�8`�(��g�]��&F ��cC�<`���x�Y-X��U�
��
���oM86ߣ0�=Z��� |������t�˶�qF	��f*%�]$3��R�Y��f�wh�@V�D��sy�7�2�z� �� �	dC選���0Ȏ���x�5�\rqC��� ���e0�{���$˱�H�Z�)��kԚhl4s���	�03`%ؑ���%0� �ƀʰ܋Ē��͹"��?����qP�8Ps����W7�T�K �%�(��0N������ʫK�r�`t�_�������t�、��j���� �t�|��ss �{W|/��1�7a�d	)V�"Tٺ�rZ�K�f2�e
�Y$3�9�1� ; Orǡ�錬&Q��z\�M�}H�����*H�T08c�	���h�f�A�7�a����M�Ɖ[&���R����06�H!�w����X5�T�V�,����0Y��'����׾����Y��	vAg�<b/`U���l��#9ѩ�����ݏ�:s�4���4�p�&��GJ�?��z�0'��x�̞A���Z��	̗��d)˷M�=��M�Qgl!�W��ކ:ܺy�4[Cǝ��9<���<J����_���T����袥ڏ�u@2َ_���L����m�Y���Z�7ӹB}	P��y
R�� :�q��xK��
�9�3:	���8�n4���rb�Q�ܱ��2	$���?�a�q�VP�>���w�XZY��eJ�;Hƪ(���z��n"��U_�KvsNG
���`����/I�s��D��k\��y�F.o����ќ�s�d>��W��)�p��^[2�ATC�<+w	�Ad3c�_.RK����=���H�:�	�����~���p6^��ɣ��XpmГe N���:��[�|q5 6+ԡ\��~*���H��$�#�`�[�7?�۪�w殦��`M�]��KzE��谘�d�`v�r%8`ʸDjӪ���A(���5H/!�9�m��p?���`��"�H Nc�p�Qv��sj�ZI� D7��$��x�9S�/(U	8ͳ����?�_P`�����,�����SNa+"�0`��?��1c:#�Ha;�w`6�� 0��:�}�c�����U<m�k8�|�qy����fwW�^�NB��8��������
�q��-��BϥHM��.>��m.�I`E����pU��a��w*)Mr
�'=�>6�3hZ1��ѧ�8`��VQ  "���9+�/e BG��#�����*�e�S�P�\�>~�1��Y�W8x��$�n�{� 9�(�L`}͹���-����]��Y�a�qZ��I�|�b��Q֓�w!g����x�{
�Օ��n ^�r>␺#�^A7��a�7��h{���X�.tt�!�Ci:�yѮ�tIjWk=�j~����.dq�� ��G�V�n8><���n��|*�I Y�d-t켣���MeL�a;y�}���κ:G ���`w.b�Rm�,`�~�bg�E��5	�E���^mU���;�-@6N�.�D� ���/��"뙨�~�v3�I����S���&���@�K z2�/W!�Uh�[���eM��vGO�-�v�,_�	�w��)7��/L/���
����P����ǎ��RrX��4���� �ssy^�{�mlH�����	
�II��t��1  �_2d[A����7&43oh�.{:�5�4�邪r�g�4~m�)+&���H�Mb���\ ��w�?HT�¥T�@)�ػ)�6�-���L����8���_6 ���l0 �]p�KY�fƯS{~
������4a啛'�u�W���TC���+��o:�#D��H��.֝U_�ڸoK:�Fi\]��2�� ����>ø��Y���SH�WC,9+-�'o�'�6�Dw��𽺶��X��sx[�T�D�J�(-��.(� ���M��5g��l�c	J�R��'������ +�6�mqI�ad�٣
&�(����o��8¢�2�a���X��bW�����"ŵ��6��ï@��Is6;� X�a;Oc�i1���dAP��>�
-(�̨a�*��e��1}��f�%�s	�
�42�>�_z1��2�:���gj	�K��h����B�;�!��61�x�ߚ���J�=�b���
ϙ%�����8��|��+Y�du!�o��@ ���z�ǒQ��1u07�̕KF6s0	q������g��m�H�43�d>�t����`Qnw��}�lJ�Ƒ��ݧ��������%�9��)'Z[W�R�́�G+�M��Dq"!>��⓬�9��	���U�yma1��*>m-V`������I2q��-X`��]VBe�)_w���"��	V9_t$�}5����b�}N���Ҝ8\�Yo��<��{��!��,wɢ�6Nl�k�B���)+t�x9�N��� ����J�wG%�+C�����$�$�Sy��ش�t��*�Z��e�ܚ��es�)���2�'������g=Ϫ�"���ԡ ���1��<��S]���#����M�¾����Uq�2�-����1��	d��LE� �XS��:�E�6٤-*�ϥM�ŗ�
��Dɜ�渡�����ȴ�v��3!RTA*�=��8���F����i��g~3�� ��r�x_MujZ�}���O���yv_�5|�JY��4�L����1�i
*M�ӝ��7�E��U��&�˷f��V�0�l�L�����01P�j���vchޘ�@YyJ/��k�,�t�8s!F��dZe}�b�pE�ho�v��(�X�$0���,�6�?'�2�ln�5���+�,�`$n@7�?�Y��kZ��?�WK�D����	��[�G|�O����������1%�r^O�_�$��i?j�D���ogJ    �cFg��Pt"w��r��rK��C$J �PiS�V�M�%W��5��{b"{��ic�x����>/��k�Ċ�ȱ2Ϻj�6.�'�_B�b��:0L�;��C�{� �f.�ų���owSb:��c �4I�kO�X��1e�\h�e��f� �`��t����j��T�H��,�X9~ᾖ.�C��.pL>��2S�Nn�,����9o*��G��nўN��k��Z?��`ǰx��f���p�7-��S��k�ͨ�����lM<�h3i�Nm�#ɐ^�{��Twecm���z� ��;�b]f�T����[i�9��THf2�0�m5���J�a����8�M�Pw��cu뇢�|�� ��]QJ��؛�'`���������`v���=瑻�X��T�z�+sm��ޛ5sw>��s��A� 0L:��9����׆i�my]H�2d��.-7�,�������.7��?�Jfl�;N�Oh�,]u�I��	LE��F��c(��e����Äb9��E���[P��\b�`psHODUΪ�^����Fӱ��{������z=<��h���撂��+���UM	UB��#p���^�\u�M��u�������B"-��H�nR*(��� �~?q� �I�L%>��UQ����:���7� �%�o�JB�)�5$�F��Œ9��m�E�\����;���4���9�eɤ���Q$eV ��3�sr =	?/?4uߔ�\��rN�G���bs�&�u6�6eu3FsC�ŤY��p���Է53����7["�����ј��֠7ޗ�sR�t�P��L�j��ˆn�#��I4�x�ֈi��cU��H�[ W�8X�� �^���*��sO�ʤaʗL�Vq���s#�1�}�������ѯc��8L��˛�g�ŏ��_������]���f8��ݮ��T�O�A�I7�b$%��ĭW�T�[F�O���h����1>L�B���_�Srf�yL`����O���D0R*�To��}k��6����Ue�5��HS�.�~ "+����mA�B�xo�6s�T�L�#�Oħ
���rp+0�4�t��4��2f�O.�o2�*.�^��{��@�^�=K�(�to�۝�����eh�����P����d���m�h�\z���X��~,Z���G����/p��:�zt297P��K��Cf*k�b�X���O�y�ԾjFN�͊t��Ν-z	�4I�2Zw[���a���#������Dq�0ȫ�N#�2��t
g�A�!��dNc�p�}(��6�L�؄S�P�������=��K�4��8�!OY1�����pd�X��Q�
]�ww � ]g��z��،�-��UT������d��v2���n�=;��M$�@�WJF�Y�	��V?=�Զ~�n+��3Ꝣ :��:y� �L�s�l�y��%��l9���4=	��iw��o���ӎ@ܬ�����3��Uǲ���8�uȢ�0��0N ��:V+9OY&��,�Ӿ�_.͜IhDp_H�:�(���:%}�y�́�<�5� <��!Z��Htwv��3IKsX���$"I�0>Z�aw���i���� �H=@��M�'@_tY�p�2H�m`����teyU�&0n =Z� ���}qy��7��1c;TH�~�@�r���L��9-����Wn�
������O0�#Y��M/����7���4h��gd��Yx|��
���C���~��k��6�Cu�J�l�t���"Y ��Y	p���kW�S����@�U�c�_PӔ�]*����ao�J6�,�l�/EQOC������6<
D[��X0Q@3�ـ����E;6EI$�L�_|M0�`��rK�@8��K��h]��b�Z�K
�-<���zwnY�
z�Q-�usr��]ݔ�a@Pޛ]�\����ƪ� %.:`g������h�hB~_Ba`U�^B����n�\f%A��h����7�>il����v�]�Pk��F�*�xɪ��I���*�*`�/��GP��d��Ѩ�*�<��ym�
�kk�y9�>�n�w͡�<SL��0b�vcU�s0�j���S�����`A5����-"���z�{�q�u���g��g��c� �N���I��)��Mِ>h��Y� D�w��nZ���f�zZH�
���A"����2���)����Ck�Q�RU)��Ռ�\� ��	P4V]����r����4R0	�n+E����j���E�6��'K�L�t	�C�;M�Vπ�_ U���qqYA��r]xoper��ƌNmKq��:����y�2��64Z0����p�U3U�#	[	1�	p��_Ϧ��=�M*R��I�L{_�K�$@����A�5���5D��X�T!���C�As_�D+�K����朗a�ps�	2�L$�	����������=��;�2��VK(-j�Xܭ�T�l2@N1���ʱu�a�8��l6g�R$��x眮�7,�ū������;�ٲr��n��j�1|;�[�yR1,ׂ.�)S�]�̝��8���>�*q�j����Ĉ �f]���rS����ƪm��B"�h�%ķ�B�S��x�d�7}�\� �5Y��\��(��y���s7 B�j��n�x��
?9.�ER�.9�+6��-��M ��t�e�%VK]:9ј�`��gF�d��?`��9�s��#?T �.[�zjM��ڃ���q��񮩆�XsJE�m�%����۬?���t�Y��W9	��� ���.pފ��rݭ!�ԗ��w36|��}�`م���7t�Dr��i��;��gݷ�3�#@T 3��`���$�Oe(�L)G�h?���=`�9�E�@tK��t^�Vn��`0ơ�X2�$驄m��d��L�%�R�~���m��TWVS�D����/���$��E_�{������G�C����r��iLT��c=X�Ʋ�F(��}�0P��X*{8��g[#0uj���m�iT�}#z�̓����	�Mw�a����צ��E��Rw[�B�����o�&n�Ү�FVL��k��V̓Lr[������e���7�҇<���!����ES���FIܞ�Xu�Ci��s��3�Ybi `|fb�Y*�Lbk�솵�a_R]Ǥ�H�����7_W�0"�S|(�����iԷ,��Q��ycQĸn�J\�_as�e �8X��/�?�.L��ɏВ�-L|4�J����lc�uq�_�.<���9���\9f���j�1�(Q�J$~��P������ z�s'�; �%�T��h�P�5@ý�>�c`}�ih�-Vr�ayq��:��S?���+�OX�:� x�F��	�	��h�C9��RH�(	5$(A+��s�����~W8&�̝��;�"��q/~�[_�M'������S�=��j�r�-�`2�5~��f�	J����Z��5�V��������ǿ�&3kM,�:5}��i�����7���'H������Փ)����/ �55��_'X~X����(��X���]���%L��qS�3�dRd*Q�[7�:]EBm���`.XC��13�-�Hʔݵ���Us1��~��&Ggr{�����=�M#��<j5����d�A ����q��/��]����ș2��_%&:�Y$�>/��*`H7m�s��9;��l�:Z� 6X%�`Q����Y��d�iZ�1�C�ZY�2���i�Ūؗ������a!bK��,��5%96�y��0t���E�X���DX�-�T�&O��L���vpL�s�|�dփXU���sx�ߍ�ׇ�gM8C�.9�c�W�����C|\�}^������URO�/�E�G�vgG�u��PO.&��>�r���`�ąx�SlE	#�eLS��b�`4����q�ہ�XZ�*�2aj;Cf�ö8L�f�b�f~�C�sRaL����c��T:��?���?�J�#&����u�ё|�1�Wi�L:�fL-��2�H��l�8��F�E    S�٬Q_��@�`_k[���Y�UT����Ng&RV���-����*�.��cWt�.��Y]����C̛��_�ū���v��i=<X	�/����k3�C�1�a�S�N.�Zc���eN{��dF��E�m�Xu��
C71�N���#���ѓ��W���A(�G��Z0�˖ڃ:�N�mp(��>�ݱ@<O��fF@��2^M�κ��(ɘ��3�ϙ�XFF��ʤ�T���̐��O�d��hڠ9��{e��v�ě���kN�d�ڀ�X��K�_��40�i� �>�L�_�w�][PC���`}��_��z:�0�ޙ�T�ݳ]�X�M�!�h����@/��q�%Œ%�TA>}�zf{7-��k �I[:�i�K	��{��Հ�YF:��W�f�Cd�Z��<G˵`SX"�t�.�X0�{�5Pł��8B1���DA_Oq8MԴ#J��l��_�Eݚb���D����֏�7��r��ز��Q��`0]N-1�>[�F<�$r�,�e�}�XΡQ��f?�.K��6��aa��ƞ����rX�{*q|
�߳�u��◃���$�|��2��H����d^����:�0�z��Y������R&�Ɨeg���^�Y�'���
,˶�ȻqxT\|�	�H!�^�^϶���Y�Ilm,�g�����G����Mo����|�F2�%� �82�G�._��@�̈��X/�"5;�W��N.E`�[�cm����?��0����6� ��b`�}��fp�Hv�NB&��u����mĚ��8)��y��ud]�L�� �1я�6`k��ı�.��y3�'�|X��=�=їl)i�Π��\�^h>�ep��b3����yX����d���E���Qy�����CI�F���]�&���N|IDfa�Q�=7R���"	[{�6V�I�^������R�F`ƟfTJ-B�O>�9S��ruf�)�M��2@>U%�u���g�=z����%�*�޵�e����y���Rb�~�3׆<#�C���ɅYk��J��xtG��F�6��?�����m�u�$�ۜ�#�}ay����C���`-,x�8��+=��b�H^��Mq�O�-��+�͹7���)i�6*>[�J�Z�����n�\5f��kZM����Z�ҭɸbW1�=|�[��o��6� G�'ɞRl���G�u�vӦ-)\c4�8�ɟ���k���=S��Ŕ��/pOF-(�S�S0�Qc��`bs�FM�3y��+��&N��5���b��(�-6�"j��AMo����	�d�����~������T��@.S�^�t����u?�s����̞S�)N���7+� �x��oB7��q�����Ӱ�5��p	L$���J+�f��aǷ��5�BQ�4׼DVK=��B�}Q�����q�~�\�v�HīU��/�s*���5s�x���A��6�e_ruv}b�N_����~�Ӷ�d��t��{ܜXyk]z�1k�*vKO�z/����j� ��s��-Wì= ��	����`$q%��w�&�1�'M���N��r�����̧�[h3�4�� ����D�f�M+��`jD\���e�L^u�s��鯼M��	XOlW��hȚ�#h;����A.���bZ5��y75�+���a�r����+����o\�q���AIH)��|���C�>��gi��˦9�/�gv�z���Q؋�0�m��e���0i;(:e���񠤧�N�uԘ���N�t[�\�x��qYR!�ߏ�����T��}Ǝ���LsE��
_�|)%V�}���.��W�h�l������4S'|�������_2h�(_t�����hl�Ǔ�PKl��Kz�1; ��	襦����}���G*^�'`��ʶ ��KQݻq���ډ݀l�� H��^��q��ݼ]��@F,��N�_6�����j���q̚���h�G3��ت�?�vR��j��n��Jk���ޛz�G�Y��w|����s�O��l���i��q��ٻr5EemI{(2Ճ�dIۻag���0�q`v�gߏ�.SF���ݱ9�(�R�JH�f� �>����a�9�0��0���
I1	{�]W��.��1S�l9֕qb{x\�h��r��?����!����SO�i�Xf.ϔ��,���r���K�@���z��ѫ;Ww�S���p��~�-͕cG3� eY)Le�rs�*�_�3?��P)kxa�l8vܣI}Q ��gFN���������.�Bv��/Bv������q�����8�A�6݅[m�l�f��<i���dd[��
�K�aۧ�1�ĺ�eP�^An�8ΰ��*�K�&����(d�y�tΜ,Ry϶e�l6L��OW����$k�W�}yxP��;�	|,���&N�=Z	��M0Ƅ�+�b��S܅S����W3T��v@��M��O<*���0�%�n�8ͺ��8w�Ė��)0֎�~l���;�D~V��6�e�
�r��1�j9����T�_�Ҏ�N� ���m#��*�qx��+�>�����C�PT��� MŞ�x9|+��8�/l���η�4<6����`R?!G��b�x��Nr�g�CھNо�������Z�|Z����M�3�Rq2�3M��|�UM>�O['.Y8�IQ�h��`���r���1��>s��g���z)�-%�7ا�Y���ZH6��c)P�rΝ��ԕ�o>߳�AeCJ�0���C"?���NJS��H�B��n=����T+���5�� ̈y�\��a�X��Q�O����-��.��?�W:Fޯ�zl��3�
�OS�E��w�)f��\Z�<`�D����e��
-��H��SVy��b�v����-Wg;7k0�
ì��y|��Y��4����+��eL��"�,`��ҵ���1K���զow�ہx�]s�uI$e,��no�^�p�$��|yf�\��<M���rS��D<�W�}��L~��	?�4+��TthW���۵q�Ļ��'Xp(�F*�I�g�����~�w�7�wEo{_ �����'��&�X$��6k�/�g|�GB��HE�_f�˟KD�&0,_2�����P���޻��U�7�\Be�pa&%�4��"Q�b���?��۟�l����8�Y��&-)��ێ���Z
U&u���2:s`���v��'��񖌖��h
ln��Z���`�ۏ15�8f�!�k�ݦ%���m�w���Q2'[ ^�M߮��1_��:"�ۑq57Wf�T�q�H�)������ƺR)�}b)6b��`��+���2d���ɷ{;>>dEu4smj��<�=MY��]t6�n���
���b���K��`�W]�T�ؘ�OQg��؝84��5�&;|��z�@"�n4�=�����;:�mZ__cG�#&sY�X��5�Nf�9|��i4wvxܰ �A�����%2Uu��2ӟ�@?�ZK<�r����'5�ؖ����q!��Զ��牏��2���5�c?6�D�1�[M3T�ٜ�����
�ֶI��� l9�(i6��}]2XG��� �����0�6d3t|6��u�6�f���6�#L�36NqJ������2���:2�z����ߺqq�M55{d�N�z7�
��_鞘1߆�=���ئ��b�F��t�:��b�P�t�>D[���N��h,nw�(�!o��6�_
%� ֞Y��_��.��|=�ov#����5�(�6E�,N���v�����͏O�����1J��ɥ���S��u໯c�Д4->��k��6ދ���Iu=�d�; z;C<�#��Ι!&��Y�J�C5&F��½nJ��T����ck�'ܹO�v2'�g��7e��˭�eyU�����c��W���3:B��/w�:�,� ��μ0q"��\�؈�+|BY_*���=v��7"�-�Ƨ�T���a�H�@1K�"�yl(c�7êt/�$�� |�&ū~��T�b�=�0�����]V��b�?v��_�[߄����mQa-
z��`���_ڈZ�ћ�h�۟�=�P�d)�z�*>g��ι}�^ͷ#    05�TdU��3@�'mma
2�b<V�|̬>]�J�[qg�L�����z��5�	��5��"�LIG��*�hd�(�n��R�6����9ݛ����<����х�I�<r���'~f[-�ÒϋN��5�Yە]s�]MrC+�Ҵ�}&	��m�ú�-:��
�ðf�2؎��5W�ؓ�~��>&a�$�*�6L�k61�+����3�b�� [�ե�s����l��T�af�*�5���:70	��-�̈́�cv�f�����.��]#�;�]-��� �������)��P�w]@�$ν���4�|�����+��ݵG�$w��}���%޳�l&ć9 õ��w�,YT�IB�M�c�&j~}m*B��N�>�� [���,� ���lEq�t;�H)g��W�oxk��6s��'e�W��'��k�c�P�e2�����ч]���#쌟z���n;�]���U�/��U�i�[��g#��0p|�9�%��cc��T��A�.]�q�65�{:௴�A��ɣ?4��n/%���� ?E��$�]�{}`��HS屍��g���!GvZLlI1�0���[�}�]|<��BvJZ;.I��*F�&`֠I!_�Z����ט�l�?��!� �@l*N�J����qg/ ���{7K��u� 6W/^IPl�j�s�d�3H^��{�PG@����㕱OP���gZ^�׿��������qC����)1�{����I f�����%sO��#!�5��: ��wSÈw��Z|j$��J�7�����_���]3t�5K�] �����.����Y�՜��i��ܽW�|�1�2�m�^b`��l̖��";2����]5�q���V�ߌ����OLe6�o��`z&��VC��2���,咇�ǉ�t�*'I֮��tu�K��������m��{�6���c���bAHUU�Wz�~�ڋ7MG���\F�5%nWv���C�@���������/�
"^}����z�ys����`ZV?��[~l�t'�(��%R�}�w�v�ds傦���%�|}?`�U�
��_�]�Y�k@9�'�]+~�̃+��|�HF��L���]��'۟�Q+!Iv,_�.��qa���
ewv��.@�u:f�鎥W�\��Mci2�1�G�)�(�����LkDP���O��i�*ߕM뺣�m6}�]�����vn�u� �_/��5�q���V|&it�L�Y��UËG���^�Ş�T,4���� ��~���f�������<0�e&�Sb2-������ͺ�
��}���h�'��ւ���6%�#�c����F���z
S�ӣ>���?���=7Z$���W	H�)>��J��j���c��yO�T=�r�����X�w�?,<��|�>��b>>�8ΓTٮ�>���|�71ˉ)ї�Mެ��.��u65��uw뱤S+�S?7�����L���NC���RW�vi��f��L��45�ާ��>���]jg��a~v법�[B)�H(�n�"���3U�����t@63�`7z�
��@񢧈o�&�Y�nY$�d/�����Z�p���'J��t��G�FQB߽g�8ϺMne�i��ՠ�c,A��S��0k
z�ٗ�:H�wvhr̺�p����ِ�h�C�)п�F���,j�t��Y���{��%{o�A��]3�o�d�Ish ݂��X?f�3����u�}S�4����1�-��W�ۨ�R��M1�i�g�����@�6;�M��P+]�P�~���r���ߔ@X��-�Cl�-d�J2A�,�^X�����wl���Lqg#�`$��4I�e�n��@��M�}_2�%u�(۸�m�^�j����Y���:ے9��C��=������ p��m&������u��l������kǜ����{GTܦ�>o�L�k�^�MD� d��M�y�QtQL���쁕=�(�¾8���7[v�6�P��lg��\3��^�y;ΐ�e�j~��zۢ����}$c�6���%�d�A��B����{COP7�p��f$�����o�0�&v�4Grbӽ�vy[4[��ݘ���^Q��~���#f�ts(+��m��;Yr���DQ|il��Ժ&J���S���M� ��~�llӫ� 2dY�dב�!�Kv��s��o*�h"���RMO�J�ܛ���/۷&���g����R$��3��R���{�����-NXՐ���v!�J۞Q??�����v�	���gH����x�*p��k]�9����Ca}p���C%gg�����_~�W�V�B�L�N�o�q@�K�������>��*��=kl��z��X������C��{~�6�i��������# ER���4x��ЦM�O��7�5<՝�g�]�d$l�s	Nu|�W�_���{ CХ�F.l!%��ylf�zr['l��hiz�]�9�2l���-mcf6��h�1�����X��k�8���P\�(�c�T>���X��S�]��?�oѵ��/.��P{�&�</�󒒯����<O�wi�����7��8�ǯ$gt����� ɇ�?��W�	Z9h�+�Dâo6�M��{;��?�_5o*�.�}X�Kw���юN#�$��Z���3]@����d�طփ2�P�vZ]��]p��^Wl�q_�?���Y�X�>�@V?�wvx�y��lg�Ƥ��Y]k�g��w`�ݣ�43|�x�'��#�x$񭼸)��J�������&ن6z>P6�b��=��Zx^�N1ǐ�D4qy�@B���-��ȶ�^�qt�fG +��f���b6@d3X���Tӎ5�m[�m��80Y3EA��gu��(*p�g1�c[�0�sp��:3�J<'�D~�a �׸�)?Z;�֕� �`�>��OF�������'U��W�x�����Sv�&V6!�ΐ��۷���)M����{,�I��c2NˆvAޣ����9tys�Q#�"���;֤ʅ�W�<<]el龷)cC���c���J�~�N"��צb,B����hֵLcز��o�Rڻ��g��ɎN�����`��|d�⧛#$u�'w�no�`z��;,�yٟ�;w�`|�o!�0����A' �`�Ԙ��m��]�F�Yo\����HU�ru�S^�px{o˖��C!���jq�UZ\�
e�A|�!}� ˩9`?ո�T�ՙ9��&��/χ��d�~�H&-L%� 
�ʎN7p����}<%ik�H/�%���p�..f�01d`'Gl���>M�S�x<�[�b�2��\{�i ��z"0��(�����hƎH6�yz�����cz����m��iu����޸6R�y%qvL��� �$w��.��mC���\c�Ƕ�#H�V�ʹd:�s�uoz������������o��t�as���{Vb6�&иU��g��j�M���7�{�����0�?�5> Z�)[����0�Ka��Paȼ�nw�f
���F�l�	�۬�g��/�Ɩ >�ta��!���d"���[vy
Av�a#W�g�)Xs�SJsS>M�@,��N��5��')D=��Â1��W�6ʮ͓����̍o� :��K{_���>�٠�)�+��	�*� �n!p��YgA���c�\����Q�i�
RS�d�o@�4T�{���R�{=��ΐ2Ѕ���i�5;�6��3�uÙ��&|)��k�zEjd�.-!dio��
���	�fW����ְ���)>��|��O����cs����4���bO���L�P|�~��ܽ�t�I�V;<m~j2Ŝ &��������!���㞻>[�}�c��=Oc���#��qI���%[W'�!+6vpz̆nz�\1�3ѕ5X/�b@������a4P�Ol&���� ���2"�ݔ��>ޖb�ĺws�߮���R��J��|�bd?�i��j̳������=�Ɂ&��ޖL��\=��d��OP��S�|7O���D?{���X�>~��UΠc!J\���.�T|4�;�#xFU4�H��%;b�04������ul�	czt6b�Y�g���OƵ��6�l����緶����^�|E�    a�ШD��qh�?��WMS?J�S�NV'�2��mk�"�����)����^SZ("�hIO��J;8��-�&�:�/�SN!���K�P8�᧓m��D�`����҆�GI��*�?vv\z���1�ېG��C�qM�9����xkN,\�|P:H�/EyyZR�}���u�3����u������Wv���'��fN5������wZ���ܾ:}5�l��Kj�5����e ����o���e 0�cy;������l�7\V���J'�>�sq�����E�[<3����ѻ�'��e��E:ww� rz��O��U�)D-?����v�����	bh�X�j
sx�絸k�U�m��� "ė�xܽ�?�;��V��.m�EČ)2m\ar;<��}kZl�Ɵ�_��q���L��ښe���a��h���eh���r�C�H��Fk?+�۔��%;{��~���J���m���|��+�O����.&���T���\]R���x�d* )�pd�a��M�0NX5e��Z���zc{��9M6����0��|'�xS�|%���	�hi!�U�f�a�w���YS�u��AI��`_W��W�H��f��{���@�3g��=`H8c8� 
�c��zY���m�3Dq�+�]�����^ul�I0�M�cݦbc�foħ�eG�$T��+��C��v|چ�	�N

÷���kvr�m)f��i]�8����!�\������B�6�Xe��^E�������a s*d\� .�{r��X�Ԭ��\|7�����
���o�d J�r�ۯ|����|dQ)c ��4�`N��l]t�b|3��xk�v�wF�z�Y�fϰv/��2+����f�6�CY�<7|����q�X)����Æ3ξ�"��Be@�]��|�|ilq&t񧔴�W�/T�C�bn.xc	;+������Ӭ6ws��8��&��>}�U]2=`cd;�?m�S{e�C�(���7ب�Ea�V�L'��A	=��+#�/#d亐߹0��fd)vA�\�7V�%�;�����������Zҥ q�Y�����G�"6�	x!�g�*�Cg��m�A��$�=���4��4s��%P%T�	� tT�M�UfV9-�{)��v�0�4�vy�/�5���/�p	�kx/���`���x[�s�5C�)(ab��8����������"5�ۈx��bؑ�8�;�1�懄=n���aY9r�ԃ ��(yi��u�pes%ľ9����8�B_��S߽]�\u�c���kn�{�� ���p]d9��AT�����K�65��Z٠3��¥ehe;�<��YSvӻ<��ː<��ű�H���eÖ8ţua����D�a �pI/wd�(�[���EӬ-y�I�����o�}sb����8^&�j�Y���x�}E��i3b}��5���l��#|��m�K�i��Hh����l��,���P���u>��{�N�0H�����Sp��	k�D���h�["˪����cI#��e֌El�q�fR�ն;;�.f{�V4�	��,�r���ua�ߖ|It}�ۆ[~>l�|i��w�Y�����kH���I�vY�<�f��M�v�@���I2���!�ܛ�}6K��ڔ�w3=�������܀�/8B-I%E}���}�[1�C���T| .�X�=z(�q�}��B9��OM�`�M÷m�ܝ��V����U�*35Y��Kl�f�2�F�+>��V�]�o��	��������o(��	I�0춳3�C�2�z��X��dc���5��c�7x{G!f�w��̉�0�%(�T=Y��O��%r��5k�J�����@8@�'>������n�%(+� zz�|L���7?����c�j�ĵ}�NEm�P�<h,��`0��v!]f9�^:{��VY�r(��:�K`)o������u��_�d���>���ة���.���!��F,o=��6楆�E��bzm�	�o�(����
6��I���9V�V�}���K�����$�.k4��w�N��p�00��'P.��^:���`V�W��@8#�Ք	��4���zdL��"f�%���?�}��U���,ߎ�U����K�4�=3YH& w����U��itg=��٣k��4F��s�gnǷq��
��]c����Z�2��i����]y�Z�C5.m�;���Ꞽ��_������vÕ�����ė��c{b�D�C��¥]�\7ů7l_��z�����L�����<E�z�m>� 
�
 YM���6m|ʈ@C&"W�޶i/�L&�B��M4�L&5�+��.=�$:�}J�� kQu�g�����?aȊ�8Nf��h����=#��^�rB {��,/���(�xTyo-q�z�h���[��u��ǃ��O��-�u���.�1��i`CzQ��׏|�_o���[9���A��7*�T�J5Yn�T-�ǲ=���ڐ�`�����O�o4�3�1��d ~�P�z�vRP��Ge��i����?���}��j_F�!ჭ�?.��->���if�zP��O�C��l�9���G|o:I]Y*��[�yЇF)���������}[A�A9�0�:��(D�3o���l�c��$�$��%H��ٙ�,��M�'�%��F�3� k#��o���/��Gn��_($L���0����QCxĦЗ͖'�ޣ2��J1�/^�9q�	����ք�Q�gs�Y�w/y�DQ�����dfLN�a����k�t*��KPD����'�_��֊�����Q�Ӊ���z:VK(δ���J����� $	��IJZ����\*X_먴'�����'g�?�i�T_��C�-�bYR6(��f��|�.�_���%G����N�-�{[\����?8�sKMI�d��0]p0$�.���X�r��G���'P<�$S�<���W,�������Ї��˧��݃2AC��oO-j�.�G��P�0&�S�M=e�#a��z�����j�:��2� ����9&�1����DZ��>T��"��{�*n���U�`2X�_���������D�_����#m���O?��I:��M��^�#:��ǙR ']�BA!���6*$]��С�F?m�g�gM.��f�B��ʝ[\d�ؔ�0X[m�+���]�,�}'a���B9�) =:\�fA�EǻI����=�|q�rT�qz�k����LSL>��t�NT�翼m�Bn����Cs:��i�\(�{�����E?7`��	86��#��%���ʻ���\����=}�X��B8}��f瓭.���w�Q�l�(���tDD��n�]�Ó��X�I?v�H&��=#�r�/�'�ǻ~��2�Ū9��^O=���%=�C��{�\mJ���E��EGM_����.2E��L���rZg��,/�5���.�BE�IL0��{"���͵B�]G-焖��@]�货(�G��~~K'冁m]�t���E���8�~�я�aU�5����?��+�� :@�a��Y�0�:p)~u�=L	�1���k6+n��2`�m�8�5R���!
�g��؀�gG%��e�ݏ��9B������ݯ$W��l�b�Ec$���6W��T�`�ȳ��vWƓ�gzq�q�Z|�앞:P��P���^1[���ja7y��lTi�<F?�����검Sx�i���n=�ŵ��rՉD�ח��)�1	�0�|����Syw���)� �Iѱ�����qc�����Ҥ��:^W�	�"ޱ5�<�V���nY��3�#��P���7v�sEq[k(\T��z���a3�2������j�ԏ+qɍi��3Ul�b�3e{�)^����ȁϟ�k\�u��ΤL����Eϧ�I��vӎ����
�x���b�0!D�j��*�dσՊ�pd3G^i{5�$a D�S�̼Q�G3�ʅ~���C3RCC�+R� ��J[^�>G:*X�*2:�������q�R�q�n�Ғ����@�n��_���#%�^ �f���(��r'��?,�    # Ⱥɽ�Yi�bE��m��M'7�����c���)���y��&���}��hm������&�:����NՈB�ǌm����g��}�Aw���쇁�ɢX� PDΪ�[\��	E��)Xh'K��J���@<�t�;B.t�o?��y}���\��2���PR�ۃۧ�~�?�����g��1�+����5q��|r�U�Kg񁊙v��Q)MH)-lK��Eq8lJ/��?IZ��SY(���U�a���.Qo������������&	��)��d�Z��@+*��zhX��C͇R�k�=���u՘��.B�4<�p�=�S�Lߡ�FwYX����lSu�#
E8*�A���ι�.��8�yɄ c?�9�0�_|������e���z�
ܼٝM�\�(TT�;`�rB� �cѭ-�F�"j���1��T!��6�YDN�[.����Fq7a�K�ȗ�
"��z\8By�V�zaybY�Z�M��t�_��=�k&���W<�nmmq��$/@�0�'��Q�PǑ�A����Ȭ��{��2���$�z�h�������Ed<�(n��l���u���.�TL�0AΗ�9�����7�t��`�pw��b$�W2�^���������*g*��v(����n��d:��N�y0T��me�i�����`�8y�����wT�VL;��@W���lV���b�^u6��	��~"۬�&w⢄���{�
��6�S��PD����8q�D-0���q{�(v���6�#2F-\ϲ�޻A���1(#媵a��*-A�}7Õ���]y���.���lD8z�0��(k;Ĺ������e_��(��؞�Rj`�hW��g�ia�}L��e�Q��6�v*�!|g�Y'B��t��( ��
�J�ar#{��S*��ET#��ժ��^1C>�p��L8�X�Z���0M�)vCRTAN��f�~S��#07��e#[�P�RO�r��f��}8����c���r{��Ba]�1� jP���H���ሇ/�W����q�S����F�@����������C�f��m�{���D6e�H@�QϫM��;p���wM}l�w�>���K�0aޗqP>.���g�nm�2Y�
�}64d��Ҟ��?���W��U�L�@��L��:�}9r6��N\��74��gee{��b]}�'l0{��h!�w�U�gM�>q�t' S1�[�^\��f���i��~(YVf�`��eJKd��P��f�_�Nq9s�.��i�~���������_��>���M��R#�v�u{���̀�⅛P*F�HQ]�(ѿ�,kz*�t{�>�&�>���Qh篊�E�".��F#k��e���h�Ynߡ��<����=�_ /��a�H��.G�^'�N�Gc�!PiNf˺__�x%��0/1e�i�bʓ�|�F���Ś� ()�s���I�&��-�k?I~��[vI�n�Lp�֗��
��Gl�kT%�8P*�b�#E8�a�=�v��~��㸎7{�^�ӡ��F�~�NDY��e���$��Y�0���T�d�Eab�/�#'Y?����<"C]j��ΐ{���Q�ĺ�kٗ�B��Q��$4F��:��P�zW��$�-㜓g�i�۪����ݬ���S��$�O��N�h���E�j��IB��P�Z8Ҋz֮�{͡Ar/G�)F����//�X�v��������q��ˁu�#�Rz�[96�S�}�:��b��B��)*+7����|t��+y��?�
��l6�|p!�4:б�Qv�)W�ؼ�:E�[�ۜ)�N�PT�:" �� >���B2�)��cz��D?�Q��ڶ(��ۇv���gz���B����t�P$D�-������	���&��&����ڟ�پ���s�[{�oU~@���K7��  S4�)��⌯na�7��eo�����%���щ���ƣ"|\����<!�7@M �H>X����mSn'��+j�K������dm�8�o
������ɕ䈯T��^���(�}��w��(�6��^��<H!��.�vQT�e�H�eEٚ�d<�eɞD�n�����k ����Y�EG��1's���n�흱^��vN����������gr�lY��v�^�?nE�|���`��~AX8vl�	�� �����J�14J���w_6�Ĕ�؃� F�W����̀�f`?�" 2A_�;9��Q�=��e��7]Ξf�L�G &� �3��Ф�*y�Po���vq+[��'��I��UFz�Ά�aM�X1���%q	�s��* j����2��=���Q�L���Mi���b�l�nKP�Y�?1F5,���]f�^IM�GP�h��(�=gc8{^L�BTr�ɡ��mu��bw������d�C���p����Vj����:
�a�r�DU�u-��J焪�v�q�Y��}��<Nx8#�i��d��`��[%b����D2�_W����&��h�㟊r��ؘ�o��R��U	�'�iyy�8�A�X��Q0
B�:�)K�;7k�֐G��,�a:�Q����r��ɚ��@q�߁���yBX��ľ�)�w�5"���<=�r���e`ei�����.�uen��p��#���誰���ڻ^���H�J�.�2B=���]��Ͽj�B����r������������l�����J ����חw?S�W��\U���GX���Xw8G@�0sQ�P�ÏN��أb4U��ő�Q$�S�������R9�����~?��]fa�v�\nI-��8s�%}S$�9���N����f6(?ʊπ�y�>�ݐ���z��2��)�,�߶U��:2�_ I�vh���ͮ��,ׯu�.T C3U���}p{��Ź=���k(�� ��� "�x���B����n-N�LW��N�H��^^>��NN�/��/��|��TB��T��&��R�te�֨�-[��̉�=�;W�q9����˨��)Y%�0�'�uW;۪�L��4sF���^J�:h��'~��eHK<���V�;$��m����$}U�ۑΘ���mR�b]׹gT(o�c�	���um���s	[���*�3�����?�v��Nľ�;�n��%ٹ����;�(������_�, 3ޒ�����; 3��baj:���"C*'������
ft�kzO�@��g�D�C����<��X������k��#���b��:�bѯ׉J��e�*��V��$A�a���C2�����t[7��TO�\�P���Wm�����m�g�����3�mڡ��<�D��l��X���bL%(]^�`#b@�D!�{.l&�E��8�H����"��T%���N�3���)�Nd�
a�´L>�&tW�,�N����� +���ZA�Md����v��S��j�^�[�OC�-F��_�?#�k� �+LTg�4�/�I��n���.h�zύ.z]e�C��J�|Bw?؉�bޠ�t�Ȉ
#��������#��pQ�f"�SS����mS��"b?1�Ѕ8Q�Hj�� ~��	W�A�`$��:۷���nƠ8]'8��,������Be=��B��(����q�p��2��7����`@��v0�Ɋ ���~�r�_ߞ��AM�{�H�'Mȉ�ۛ��ف��h�|=wgf�;�[]&�o0Ahˬ����j�o�7Srq�e)zb��#�:��l���ꋼ`���Iv������$ŻXyz�|���V��՞Đ;#)2��x��G��/�r���b|X�ĩA;x�@V��:�t��b���!�r��j`��D�6�s!��_�Gf��w8��}��$�{(l�xt��AZ���U1�x�y���P����Z��hLq+t��sW����10���) M�[��l��g��R��@��"�OpFlP�co�����c
N�$� ��zI/�[�,Za%� ��{u�_P��gcy5J�-�ni�Z\N˾1�I`w%z�#������`t�5o�ǭ̓�CqkL:S�m�#�'.�X:h��rآZ/��	�'�pn$" �  �N@��~j\�����F�Y��a���;�.Y���5�[�C�n�~��Ô�;F�^���)`�C�!u��ve
9�(#����KL�~����^[�b߬�ݾ�)9m�brhön�j�����t?�?�~TEz?���+*�����c
K�_���X�h�U�G~h����I�s�Bu�Y^m?�`J3D�@�� ߣ�X�N@gF޶�@)�NG
R�
�XD�r�~;�՛(��+w��vJ���$���dYu��/�k�]�Е�V�4��&Kh&	=���8L���*�Iy�[^���+�N��^��r�{�Oݻ���6�.d��ߴ��H���wm��w���ц��,��\ۚ�](��w�Њ[���O3�Y�q�O�����	6�%����Uq�t�������������#s��__��z�
2�:3z�K/���k{�>?�W��`qp!�+�*��#Ň��$�� vo2e��bء�^��2L�����Q���4��E����r���+��o!u&YTp}��^5[LW�����	z��ۦ:�a�r��B�wz�`���he�BfQ?J+��(/�S�!��#\)wc�6�Q.����沚��ő�p���?��-�G�&�K�qQ��U$�c*Si�5'���ntZ@u��L�ǉ��Hŗr}��-��b�~صu?~�7 " O�-��Vo�
^����6ʜ'F� �\v��s�w������<�ۥ��� ���s��r���S̓���~�lw9Ux�n+�8��/H���; ��!Fu<(����E�p�P�uc�If��˔����Qhy���{+���y�R��̠����8������mT�/>����PTă��	�?`����x���N�$�DM��O��5��i���썟�\����㗝j����<`P)��LR�Q]��z'�����_�mO����_���j��!��mD�Y\]��ʲ?c
� v�{{<n���� ��U'��وP��:�d�t/?�phjV��3�i�	4	�mS=,����Ԍu��L׉�(酖�.Y��	rIC�+!��ymĖ2��'a���cX�r�od��[\^�!�L�!�����#�K���ź6�*}����)���K�Ǧ#��LA��U�ҹ���L~b<�'ȒuL�6`	�E�>�;�
k��]��A� ��Q*�P+�`q��T��C������� �kT�^]�����3��8H���(��K�̭���sC��XY��bXwX㘡�4�G9����
��T��f7���^�o.SŅ(�a�:�L�eu4���RfgJ{Y���N���=L��#]/pI
*��J���@���s�Bق r#%^�.u�x���>t��@܏ԱS���P\��|���+$����/�������>8�A�؊��) a�5\wk�(:��(�����r�9�������z_T�M/:�Y��MO��mq^�˲�=�����A�vv��tq�ȃ�����	�$a I��-��eY����Vq�H��؋��wDV���`��p/��L�j��8�i)��n���l��eE�A���g�$+5����:�[7 %ky&�.[8,�k<�ﮏ�:���<�r�.��&u�8����T0�-��Zzl�"��fS�J�?n�!D����O���?���ݕ���O9���|�ʺXTuY��aHɒ��S�s �o�\��i�EP�>�!fۭY�>)g��M;�u1Jt	B�(n�u�P�zWtB��^��W\EH�qi`�ހ�?+,?��Ad��uz�ҫ�<��G0` ��.�um}]-�����;Rf+�ʷ��T�fd��-�.������rL�(����2���Ο��f�Җ����p=+���'ut�o�TI�v�6���E�6��#*�*��?o�4�I>ب����ඪ�ŵ��	mt��S�(ghip�_0t���6�>�&x��F�[]��ݏ}�Y����}�zb�G�*.٤���C�y	
�P޹Y1>(���_}�ri�I��������� �=�I [�R���Њ�P/��V�F{D70��#��_�v�=�Vtz�IǠ�Ͼ�~��R�ہ�P��b�YSi]�BJ렋�U��ٖ$
�P��#C��" ��E�- a}�¸?FzT�J�,��nz���)Z���~�z���J�yp�Jq�&�̑�l	Ӟ1�j��Qd%����P��f��R�hǢ$@��'F)6e�E�aQ��C��) f���ss��I�L��iv��7we�NH,�����Y1�_�����o�������������QW%UVl/@�~�z3|�D�!����
=eߎ{�5_�߭���ڜI���MyP�/7c�����!dP��V�[���zv��dN'��Z}�'�}������F�Z1����c����6���X��S�mP�)xʆ �C��'�r�����F�W\��t:�{:Q��������;Q��.*ۥ�/tjGN�8@ �%2׹�Y��A{��;��'_�{nDK⢦C`8}��?Pm�[�_�cQG�������u�a�.�|i;��&v��D�3�����Z�j�T��;^��~c����f?����۟��O������O?���?���_��}��q�`�MU4�-��_}X��A�Mw[�/c�%����ƀR#MxگVH�ϊ �<H2{z ��(C|GƠ���bV�ן���
���OG2a��,� �4�a��E}z�Ej��v���y�*6�wxbR$��L�mP�v�ӽ$\��~sF��Q�?o������D^-2rbFp�m��}S O�@,��3������n��>���~kR�J�#�t`EeI��UԵ����5��al����\Ä�&h�� ���-�ϋ��n���j{�Ӿ�g�tp�|�p\����?���x��5^3=|'�N����Icy�8���M����/ӷ��jɚ(��G���������)ìV��%��; pCO!�+�Bpu�e]}�8]e��ͨA"�_�n��j�ɿ��'O��?�S��      0      x������ � �      ,      x��]Kr庎K{q������
��h�� �YG)��:<��'��h�G.�~�����ئ�xu�q����ǣ��ӞC���ٟ�l��n�.яۏ�M�c7��h�q�v����^�*����s�Y��~�˷]c�9����I:f��www+ko�h㜇�ٽ�4�w�G��e�x��i�h�y��o����_����O{�&�s�Z����M4[0gD;Ҏ�|��y�ɛ��(6��|�~�s����k��C����>���y����[^�XC̰}������N��?>��Oo�v�ŏ���7�k���"���u���cп����@�n�˱��3y��6W:=������q���+� �؋��r؋��^����0o��ݫnڋ�C���v{���҄D��N}�?{�m�&_l�Q�u��Ŏԯ��
�~|@�o�彲��}m4?{ϦK���ϕ��߷����6ڳp��q�=Co��9�r�Ӷ�?��6���!�{�����4�ϖ�E�WJ.=Vs_gB�֦�N���	�!{���R9����ގ#��!��
�_ʁ-�Ɂn<{KH*Ӊ9̇��&��*U��h,J�mB
m�3+���#�$��;9ˮ�[s�ݧ��?{s^!�6N襶_��4��}�?�]�����C�������6B�JeD��Ƭ�\w�?�Ȓb3��/u�u��A�ß��'6g��s-�;¶�1Ϯ�j?=꺢j�
���6��>�8��Wr[�ie�>��PX�y��_���ۓ�zt�����3�">w�$t
����ٟ���=9��K��;��C�{�C-�${�^�v~c6�:�u�������D�)����]��|���+��]�Z��9G;��"wM2�,�P��{��r�s�
����P�B�sec�c����r>�"z	��mx���m�P�g?�yFLsh�e2�/�S�t���'�c�E��)zύѸ�ߟF�A��S���/?�J�~b{�������l��:�{�å�R��
j�]t�αhE|I���-#X�0_����O�}����_̃��}�v�C��r][�|��/M:��r�C��~������X�,O���܆�4�?[�K�|���?��?��_���yss�묞�~������ė�:h�D�s��܏���V61xC���~o������W=���%��9L(tf����	!��������ƿ�s�p���~�R|�u���x�p��_��T�G.S���w;��{Z.}�O�k7���y���n�����u����`�7f�~W�/<�{��'�l[����=��t4CY>�rP�_�y��k?Ԋ��l^�.gH�N�6�7>�?{�Z��T���Y���{���&6����;�R�!�}���G� 
�=Wg����/tV���������j�l���'6=�Ԁ�q�����:����f�:���|�0f\��q>��G�	3$��J/WJ}�X��?��ޝ`��������?��G2�wry����u��}�k|�<�;F�q��f1��C3~8#�U�	����{���e�?52K����.�:�	ɛ�=Efc޴WM�Wea?�LP|�P?��~s�7o��m��Ƅ��H ������u_�|nJ��U�ao?�	�E�t�,?�cZ!�r�k�q�îtjܑ��~�o~M3	z��O�����c!�I����T�{�Cm�K���n�B���9���dڂS��6���=��ъQ��F���sj{f5Tݏ �IiA���9��z���%�t�&����oW;��`t�lh=>L;�z�5E����kCf�F�\�7m�b�>1��蹗��Z�>���~�V��|w�.�6T�t?�*j��!kc��'���'L��̒v�jl��9�s�����cn�P�������:�a��sk�!ҙ8�:��仩��Vb8Lr��<]F#:��.���%��u���mk��`�+-w���1���f0��q�p�I�Ó4��]���'6���G����5�]����.|#8r��+�m�Du���5�&_�˻c�.��@�$�4��A���T��:9��R�3F���穸7�`��q;�P�(T�A��,Z�M�;���@�z�/vzT7Q37��Q,�w�
`Sj��f8ј���H��}3i�f-@H�������B�[�&n�#��B�.y��[H��a=u�w��z�.���-�e񉪫f> ?����,��m^ ��D<��ML3��:m>4P�(܂d��W����K��Ѩk R"��Iښ�����	m�XE��#yr� ��Uv�чg��#(R����'����i��*Y 0�рks��P�\���X"�6����o³����mo � �r;zO�P���Q�����%),3�����U� NX�-��
������:��/ا&��zcZ��EېU���:�m���*�e;H7�XZ�A�X�o����v}��X�
�m7b�������2ʸ� p�\c]�ޣ�o1�NV7����`����~N~_F4�n��CH���o�-LY��m�r���l�*Y���L]�f�:&�W�I���R}a�F��J�|�hos6`+ T�|DB�֦��yQ��]�
&��{��=���d��U��2宼8�Vt��r�ֲ�*ِEI7��#��q��.[(����'H�gچ���2	����R��#t��}�#����m��+�~��،����;fE�I�l������e�g����ha���3��w�pM�ݞ��
�q#�a�cX�C諔R�qe井�J�P�拃�x�Sns�9T� nҋ�<�[#�xYcU�þ�!H��vz��2#>}�m�hT-ADPXF��3jFbZ��(J*��T�}2w�pb�s�i~�cW����"'��9U� ZU��ul�ce��-���N���u�,K�c�`dZ��#${��b�g��&�<�i�tGXC��-S��*���x�*\@��@Þ?�!���b�p�#2xk^5 3ժ�b��!����Ηe��;��[��=�(ֱ��t~Ɇ���y(�Q13��˘=,��p�H���		=s�:�[���~,�yQc��ܶ[��)�������E�t�nc�aR�h+��"2n�?p[=����T�4Fc�/8�VAs[.�!�"�&�PqSR�^]r�ptb���Zu�ŭ��HR|�T�vꗪ7��aQv�I�l&(����Z�ŏ��3�H��.)�j�^?*\ ������:2�:ُem�a����J�jh[��1Gd���JI~D�Au�c��/˸+LeFB�/�L=Y8���eaNz}\����'g�ZcD!��>b���BpW�����mn3`V��E��7$��J���`���C��zx��]m�kb����|IW�7~"
�|�
 $�He�5"QV�v���C���>b,��^�eic, �l2�L;x8U����ī��G$�V�8b#w���f�,�v��z��	���=٪^�, X��x/PTߠ��[��f�h�7�6�����x-������hH��X(/w\�<u�c�	��1�D���56*�.}u����g�w5�����ܠ6~��}[,. ���$�5�|��j[�a�]��z�Lڮ������B-��`��uG�[esY����/4��u5ٶm�LD�e�&8X�YA!F�v1E�,����؏=�d�͗m:h�����A�P=ۤ�S6WO��������a��Sm�G�CIV�[�R�&�Z��I"��~,��š'2@��^k{����Y�d���������_CY��װ�6%���5��`p}3�:CV&k�"|�G�sF�P��� ��n-�2n_VB<��m�L��dY��X1t3cC6�"��x`����tu�Z�l�Bа�������X������8���J1�7�Х�]�����IƺT���� %��X,��q������ݬ���ۇ�~��w8�/��UD[��j��Ӻ�A�d���u��|��1��d_$ܭ���X�V�4׬G��b+ߕM\'R    ����l6T:6��D ��E���1�QJ|�*DN1i jNڃ���3�T���\?I��צ��u�$��V��� �i��[V�P��*&H�]&'X�Ep�S/VֽKw ��QBm���	Zu�M�j��Q2B���:�U�ɔ*��wR$�Y�je��� �m]u�:��a��!�K�|.�8�bfP�co6� M��(*�2�2Q��/6F|j�Z��|k�Y�b�Ϥ�`�#م�	�R�[nUۚ��S�'E�`��/	��]l1��`q�W.�J���lt=�	���x:��D�]O��4oա�%�߶Ȫ�6��`OI �T\�l��bmM��%������>>�[	�뉬}:�+V&K�/��M@��@Ӑ�2��͚���F�7aO�\��n7�w�m7J+mOaO he@�3)��,�5nF�d�
�N3����2rk#�	��\��`S�Q�ꍰ'���4�Z��Ѹ�X?H|��7_��{�׍���	�#����ie�.�j�뉏�z3����L�F��7���hZ��2+b�]*s#��'���6��*�M��(R#01�� ��4H�#3t���z�ZP��V����1�N'��z�MKWΟH8R�*/��	:Y7[3�Q��շ1��x�����LpN.<�r��'�g��uW-˩_�	�͍�'��Ok!~�A�
��	��g���~*�c�O"�$\�ͤ����z�	�<��C��K��z��J7R;�(q��Z|��3�w8-��S'����'>�����p�G��u���'腾��Qu�gR�n&�����M_�g�1�Oo��3�� ��ZV0�y��휒[O�BHb�0O㧲ӿ6ѱ	��&8�OjlF��C���������~�tAX�LT�.A#�	xz�Nu��b�`����NA/�uG΄�Y��;ǧ{��z��aF�K&��B5�2���r�� �`_���}�C��'�D!~�W�����hd=�G���#��~���3����RH����+
���4�el=�ɮ��Wϟ� �t�]O�8��J���H���z�}rbXa+A�D��@F�<��*���x~~�{��zHKV�Gԉ��.����B�l?����w{���*�R����H����'>����nr9'"�f��@���ʶ�����9����'>����d��XA�SF�<zE�*�t�#<�d��{����T�Y��cO0��)�I�kwr�^��M@� ��U���ħ�`d��v7k�m=��%�x�A���e<;�+e=R=b�=�3]U��_���f���뉿[�	��I���7/��	R��YG�X�&ܦ���]�A�	�ܵ��_O�z�M�������X�H|rW�#�Hq%����z��c��.��%k�Y�'��������EAC���~ٙ1���T���5��x�X\�L�;B�>9��9)� �6����8~�c�H�w�9���7o�nF���>�c"��m<����d�wB�|��4����Y�/Y�ۊ�����%�6f#�¨����Q�兴�s�FA՗sai�j~�|Y��A#�E�*�拔�hc�H �TɃ���$}�J("��d`w��ks���]���n)
>�{֛V<o���=$QO��*G+��nf~u��5�W�L.P�E���]����J2��.��g#�6V����+�$M�D�T\Q�e�@���܏�t"�0?�f�U� Aŀ-�rk5���Ƭ��%�e��'O<�M�F�lQ�SJV���x�-�~��z�K�~%0�W�Q�Vt�NB�外@�J�n���X��G��eu�]ή����Q23�m-�o[E����n� 
g#���&�[jGg�t	�p���-�\2�B-\�� <yQth),�cd}���m�- ,7��;���;g/V�b�����<E��f�l-@J"�H��y�F��NT�̈����@\�Dt�-&�O��[��"y��]���BQ����0�{o�}�����U���C��n�l����-e�#!�7�l��:��:�_���E�~ �_'�ģZ��t�b��2F�yZ��7�w�d�b+��"8M�]����{f���ɮ�Z�V*T@��d. �}n)��^�XR,F�����	���%G�代t��� ��E+\�������5{CE�B	Y����]������!<a��_�o�B���Z%�N�:fԊ�7�����5*�;�z��@Λ�:�d��I��!S>-K����p˗��5&/56X���h���$Fj�(��T��Eɱ�U���if�QSe�!�
bc��w���T��i��E�3�Շ䄎y�p�l�rx�㼢���G��<U��H����.��c��k[��Aګ��E����>U���wd8UL�X2M����5U� ���K�<<��4�>_���T���*�h��H���b43U�����d�o(Fp���*X@LQ�e'�yQ�N���ԋ�X�{���eP^)lׂ�*X@�'aA�䙌=��[�
���!�]���Vq#s�`�#���}��Mn3u�o�,��E�0b��)�����mw�9b<�����2i��o���PC��]";��5O.�6�*[@h����W�*6��MDT� j�h,AQ��e�!�gT� aȔE���������1����/�;c���h��\�%�����$��鏊@u�JV,�!��8-��hB�$pU�ӸcU�-��ɓ��^&I�Q��J <T$чP^y[�3�|�r?��&<3Y*w1��o��J :�NV���,o��0��dR�a*�~W�QX�s��dB�m�^���'���N��W%�]��d:o�+��o���$����fY�f^�- V����0�s�&�H��� <^W����������:p@X8�R�,-/ga��ޫ��	�i\���:�Y���|E�<���#1�.�>��_�<�!�sKf)c���_4/�F��Hf|��={�w��t��J@��h��p�D#B���d�p��`��!ϑܬ���Z*Y@��ݎ:�Y;�+�X%�Rc���A�U�MMؕ�*Z@聤�[f�˝�N�Xc�-��W�#Ch�y����žT� �)��L����:/.@>����{������}�t��B ��k��a�
�]P��]��QqE"�zYu߸�R_Qn���+�2Mȣm�A�Pe�S!�d��ch[�$��S�X�Lj�KY�5�vY���[����ǈ���vU!˸+9l'S�-^C;@|�Qc�=%$+.\��f*�D���J~��2������[+Z�s ��W�؛߃��ч+:�5X}�jc��LlZ���Ud��Hk5�  ��H��R��߾׮�uώ�sy�;<���!v���* $��g���v�Et[�w�C/���f$<�0
!x��P9R�nui�����kqU���<�v�J &�r+���Ν���*]��QɊ��/*Έ�������k�+qE��℮6V��eTRJ�)���!�}a4:�q��<!#-�|��::d������{�\���&�v�@E=+�h��z@���v���_^���B�D�nyV�h!Zr+���Q�mU� a��e9�:K}b{���_LZ�#�IdѼ�~���t����%o�$Sj�O��p�Q7�p��dV�� J���Q6?um_�v�]EPU��: y� �K��_����� #K�]���h�:X�p��jq�Y�\M�u���!�Ө��4�3nz���U4������%=�O>�O������q��)��(�*_]e���I0���/���Q]e(w�R}�Ca��
'8GW��..C�'ݑ{�β��U� ��e�=]�K����r��ȧ
s��*�>����x@r��Ǩ���uT���Y��ȇY�,�`i�o��N��,��吅7���'^�������A�P�aX��F\�omve<@��$7kx/�A�n�b���g�ʯ��9ն*[�|.��I*�qê;W�t3���|"�R�)�~r?�^SCc�ԩqag���
��7(ꋧ�ۖ�[���*Xgk�h �  �;qކ)���7��V&!S��^�2�9]A#!�h�@E��וZ*	2��	�n�hT�q���ҹ�R��[j�o$pH9ZC�Y��E����1U���f����.Fu��_6����gw��(ڌz7?1�J�����T�˺gtZ%����������ڼU� ځ(7뙏���5��V�hx�l�x"�J[vRi�*Z ��J� (��vcй�U� .�f-��-�,�@T�n-�{G2�S��hy�݋��J��r]n�y�(ط��+/�K��~O���3o�V��i"n���5 ���^���D���Z����ﮯo-�Bu2t�:܄܍�j�s<*[@�?���a�)vz�ڪh²�LO���s��~O��v�vrf8��C;>�{��Ĺ����o=�2�V%����3I0<��l�Ķ�]k r���|��h�>f0- �t9�Y�x��>^�do�ߪ�:�yD������m��܍U� �.R�$�Hز�W��Ge��Q��p׋�7�3^)��_�-@�d�m�}�fY��u�_.�/���͜��FHm��U�BSeQe���u�L:_. 4{���%2Z����d���-+���:���Ճ�/.@{e��My}rO*`�
�+KU��}���_���-�X�`�Wa<cf���o�q|46�/(�v��@p�u�*[����de�D�K)�s,�- ��,��2;���g��g\*[ -!C�(Fx@����cޥ�Ŀ�4���
?f˯�U����<�$L��B����KE��ɒ��B�+_췪�#�T��P0E��3_Q��)�*_Ke����r�Y��j]�p1fV��J�	&/sZ�[�w<�p����\�לּj��w�Z���r�r ��}|R�����~C���uԯ��K�y�	v��!��_�:u��X�����q��-K�������s�������      -      x�m�I��(E�b1et��K�u�U�eV��	!p��޼��g�>j�k�����[�Ӟ9��x��g�3�V��������{ξ���~�Q�3�����~�N={����>L���ݳo��N^��y���W��]�Ye?���,����}�]�s ��ښ��]�n�)��Yd��O{yo?�-�>|���k_~>V]Zi���O�v;�g�ۘj�����vj�w���V����v��mU�����g���Y��i������󒹫�z=meok��q�"�Y���yxx����Gֶ]�y��?��x�l��I+n]�[�>��{��:����y�/{�6O��jK�ߏ	l�����]PK���{���3��J+}<}�nFe�w��.��ϧ���}���")�J>k����8���j�<�»�N�������~�kTo��;ÝB.���\S]}�σ�@+�>=�p^dj�����-aP`�o���FF-���Ƒ���p�V\@5X����9xn�<���x�@���/[��z�"��!�V�:�[G����<}����	�:7���0h�2��L�kջZ�	Z�v0��e��������o���#�}shhe���
nU������Z&,h�7q��W�����~N.��qX�x4#��9�o���`���*�AX���2yY��h�Y���r�o��1P�l��V�Ye2�R��_^�x�ɋv����;V���g�SW�,�<�T��J-����R��A(/�oߞ�N��������Qxߪ���8.���Eۑ�^�zGѼ)�p�p��y��<��c$�ߦ�#}�[�=��sQT��H�e�Onz�A^�./��o�r��W,�{
���R0�\@���+��;�N�\�s1ڵ`b84�``1]He���˾�J�u��V�@��:�'�/��B+�5@��6�����,�5����=@Ky5΀��1g_%����*�2>�`�����l�u��c�P9"��� v`!�W���[pG|0�#�O�G���gg^C�4���
��D=��.[�{��[Xu�-�Qq��ߞ��nlJp/ұg������Dad��������"h%V�-�S}���jC+�G��\-�/�ƛNA蔻ةzk�߅�ݷ���X��~rq(b�Z9xUn-Ǿ6��ј����������`)Έ��v�G3���3cq&�v9�᪠.�DpN:h�����$���D�v���9����y'<Fu�p4�p��q��0`*XZ�X��Z�����d�֨/��P�>��۞������Eo+���1`s�8Q$��r�s��9h�W��((�:�����"'h��n��(=:�%�˒˃b�/��82��]�#(�v�G1�
\�AH�Hmb�=����Õ#l�
��/qhuP]��㈏*0���~�E�����И�����:�J�T�L���0 �Gx���{ZS�F�ʅId�S?�*�.�+��`��h���Xh�&�w���!�����vBb
�T����e{8�S
��:��(	�Ȗ!G
��m�!G"��Ȉ �"�lw�	�#d�vk0��x�W5�2{�%a+�<��&�����x�+���bO
(��>"*l�POL)�l�^�#���.{ĕM�c�8�.���	�./���DU<<
6�qZS�6�.0���~'Z|��d�|�yU8���b#�̋����Ԇ6={u��M��qd0��/D��	�3����=	-�t�	���P�P;ݨ��T"�0+����|iw9	��|P8�������pJ�ݿ@��WN�>a��P�:\���3�'  t�xx��U΂@���ux�P��_�G�-
����	�t��%~������w���m�����Y�J,�iG�@��z}����W�%�1�ˍ���"����㰊Ҙ�K�@"�=�jz1�S,����.�m�f�>m�S�2P��py�3��R������:B�ī�T�Χ}P��J�g'�M U�(_E��m�{#84Eh�����X���0�!�|M��� [�;��+����s�+£�v�b]���y��K�C�l
)Dc6����& �����t@�XgdbK%�T�4h׍x�e1��C����w|d��ٟH�ʊ�L��m
�j�2�&^sN)[�l����{v����8p�j`�a��1�8�hC]�9X�u�P���F�����G(\�O�!0�C׎ue���e�R��O:q�(\n�˞G���AUR=�6�b�����X�A��9b�X` �aa�!2	s(��%bm��B �L _�	bdDm8%������빵�Z�o����'���6��`��Gq �&��P���� �ȿ@��
7���x����8>	�u?o_���ġz b��〆.x~1WJ5���?���H��4\"���%���x�1Uz`qK�����H}��1�<1��(C��D&M�|I��Hj�|$2馏
��8����I��X)0����(����}��1�D&Y���1	/��J P�.�D�M��D&�Tl��7�I� .'u�Ёσ�� :�D&��B��.�5O�������������������;�gq?�Ԓ+�Z�|��f�����?'D4�}��
 t�G�x�\�0
�EU��n��s�܈Q�$�}�X���?UCI�/�>8��<��7��E��9 �7�Gк"j�m5\�5==^��M�G"�.�P� ,pVS~ahn���u�|��~�>�5�[Xr���s������5��܈�8Av�-� ����)��ށ�"�-U) 2�L�,]����f�/a��2=P�L�|�v��x�4&L��;w�e�L���C�9'�M2q1��צ;dt��W�,#yE�x����Ggޭ)Mc�2A˴��a�3�E�����ЊAI�ց�{��A"�,��-:j��&�t5X�v|�\Ȧ��L�o�'dxHP12�`P;C�^a��
�V{�6�3)`��"������`6��I]��2���L�	'| �4O{c�M�LQo�X��C��8��A6�D&�so�k�� �c:i>������(�".��
��C����T�Y]Ӻ_^�΅�������5��!�w«�kw9dj����$�1I����5��m�_Mj�b������/�k�<���D��L��/!4�l�ޭ�#5j�jf�G��h�js@6˄G�����9F#8�lz�D&M}������	��$l3�r��}�?4$3�w�Ԣ�C�(�9�#H���2p��I!��*A�fm%!�#ޒX��'���I�b��Z���/0vײ���$,��k/���G�}��"˄p�Ke��$�0]Ws���A/�����ό0K�wZ$�"�Ո�1�I����(l�]I(p�}�BZ�L§�>~����&�@��A�r�r}D<[F ��C�`���i�B��PN$v��P���>�w�l.�r�p@m"��a��5[�֡\V7` ��ek@�� -?hr16t|d6)���J�5��Z[X�j��LZT���5�U?�Lªw}U��Wȁ�Dɏ� k��H��`Fg���� �������Q���}�ԁW��%��+?��f���Xs wJ 7�@�/ �r�D&��P��Ǻo$��ÛŰa6�a,<Ez��#5͌J���V`��f�쒇\����,�O�.�83I&�4�G"���/N�D�FD����6��Mz��b�)��I��?��EG�ww݄Ih�p.�L�3%2	���^��n�Ü�Q*���+���L���$�6M"VXF��J*q�� ̋OY���y_Dc��Mq� �@����d��1g�.aI� _R�2!����;RD���>�\怷SF�D*]s������Є�M�3H�0w���oL�@�̃����ݓ�6�`�6�,W*�.��0Y�s���?g~F(�����$Ls�� �;��*x)+�$�u��i�a�=w�iq|B�Ǯ��\�2�5�d�klU�xs� �  �az"�TN]&�m�)��lHCcݖt�	�f��W�����W�F������$G���N�c����L���.���m�1g��ME���G�ͫBd��U��`;	�wm;4)b����Pw�J�xk�G��$��>i���{���@>��k��ro�2w���d�*SV}���ǘx�P�N7�������o�H�O���j8�C$2鏂��j�፼Kжɤ�e��ٞ J�D&�E~�6��%�IK�LZ�����^�0�m&-~�$@a=<ҹ�B��#i�`m��x��k��vW��ȡ�lĭ���	AH��2`{����_-,p���a^;�m������.8d^;�m���<tt�=�����̺4vsj�@�#�^?#eI
U"Z��i�ێQĜ���o#pH��ί|x�]%-�	�=Lj��e�vB�n)SZѪ8���k&�|Cd}h��qH+!K��}�L�t9��_IPRvn�Ix�j�a��VW�ź�H��]�ys-�Ad��3���y�������.��O[ �C�ݿҙ�'��+
��ۻ���j�]$�a:;)�e��V'�M���l����kR��Uئ0��>�:`�r�D&����#U�̚	�aw���_q�.�l��2oR2����c!���� �G�f��y�+�����9�ʑ�_�= Z>��C��-ט�T!�����Q�H�XS��ߒA�uV3;@졡�)2�?��{��Cd��",���E���'�ϰ�^S���]�t��Ե�����A�f�����ܯD&aL0��c�tY���$�	�>6:X;G�d+��.��۾%�4������3ޟ�!]h��.���#K�ɡ��aP�1�ϩ��zEg��G���*�#Dy#����	h9m�"aA�eP��w�NB?j� u�����Ĩ������1���5�@Kx<� iƲ�x8��G�ӿ=!j+��\2�����%\]�L6��1g��%7n�ǿ��?���+�IQ��A�e�nvio���&�[~L_/�w0@_�E���_�ᕼ�������A�ѱ����{����)�>K���͋`��k�gٍdL�*��h�-c+�܀ў&��ҋ́��"3=D&�Ԙ<��D�^�7��I{S�~5/D��1�o�F��7�;�L]'}�5T���Ni̹���Y~m	`M�@,v �i��l	�\�(mt�!�Pk�~u(=�߿�b4H���F����vKj�hK,�S2��w� =L\�k�+Ƃ{5�Xl
u|�"3t������6�8~%�c�!���$�:_��pZm��C�݌b��Cc���x�e6��6��͟��:̬P�w���4�ֈF�"��H�!ڰ�t��衑J�Z���y& 2	sn��b��OS��Fv���A�} �<�$�pj�y�< w��yA�D�A  
�Iw�5JV#\,p�Aѳ(���I�Z_���Iʚ_V0Cb���.A�obX�0���n�j��<��j����G�̶'�ܵ�0��7D&�8%ᒌ��hvG�μ����@����}�;���6ul@*�X������&��7B����y[z�x&�=�1�_���>X�r�ʹ �|��f�l����äo�+X����:�e��t�Nm�1��&�S�w��/ 2�'�R3��A�`a�I,f(i'���r�\fr�L�ܪ*l!&5��8��eq���#�	��[� ���׎N���pt��0�Y+��W��M"�R~u�[��V	��ٺ9��>VK�۴�"&
.zݬ��i�`H,6��N�_f����Ȥ��1Մ�+M��B'a���.�6�#��צ)��料�����^�h�H,I�
�_��mU8�E����'�(��I��@��>�6j�0������4Y[}>"����n�r^t,�Xv$l���Cc�/+��a��Vť���<��4��e��W�f��Δ����`���T#kآQ�d���Au
[U��#�E�����f=����N�����ꠍ;S�-�X�ux+��o��`�����U	�%I� ��]ϯq���H5s�Ȥ�����xΦ�e�,��9�_������̜�n�햊.��ig��9�ۛ>v�ط&�I���n|e�m}ɮ�cS��� j��X��h����<��f��%2�"_G��~�>ᐊ�* G1���M�'zSԏ��Ӄ�����$
�>^�JQw:�A���8��a�MP�vd=}��eb����ZO�6\z�Y��ՙ?y�m���A��L�@'Z�����&<�i8H=D&]��\� �BR�t/�X�*��S��9W������l�l�-��0���r�r��#�y����`��=�'��	�v$,&6�g˺D&mZ��3#}mô'K�
¶~3���n���mX�Eʹ��I�wc�I;�m���C��^��~D&�Sb
a	���لk�L�چ{�8��D&�S�DP���Mh.���;�o*V�wD2��S?�d5,"4vf��!2	��_�f���č����$����E���Xs@���i!8fU�ʞ:^��3,�1 PW�iO���R�M�J���%�J��0�v��?����yf���m@i0�V_!2��I;��fK��[p��EH���(� ��"E�N�$��K�\����mw#�;�"|+h�z�c�O�'��肶�O�[�Z���'��b���UČ��?�~� �m�S�-.�
��2k��NW��n;��U!3���b-�\g�%����Eo�9�cb�7E�/�-Z.�h�M7	�p_te'�k�(�b�P�j�2�SW���c������"�ؗ0����f�uLYJ,q���X��R~��@����֞ef���r�,4���ج�DW�E@n��%���4�Ko���Sl8�J�BQD�*����)�$)8�?7����d������t6l��R����%      .     x�}S[n�0��S�&�q��l��B*�B����aY6������3u���w��Ͼ��?��?c�}�R�Q?�v�a܂�B�֣B�����;��݂m� ����ߦ��A��H��ui�i���`)�}�Y=�LT�rbH����-M�,�	�Y�V~l���3�ٺ�fC�HniM��P���&#H�uXb*[I3�D�wLKrQI�frj1�=���a;�_"�PJe�O"-��]�"��pf��^�q�N��AĮȤ���2IrKɵQ!�*��@�uz�o �T�D      1      x������ � �      /      x�t�M��H�-�f�
�z3.�f4�qǐB
��T)T�/sGw��3�N��.���f���x@�5�=�F�j�T�[E���%s�I�P����ʒ�9ͮ�{����[֋�n�ׇ�Y���Û2��Mw�D�E�H�O��y���e��y*�>�y^z�u���"ßfQ�th��׫a|���Z5}ѽX�;O*�B��$T"�d|!�]�ͫ�Ȼ.�?և�������1o���ʽPy��n��k��(������SB��$�aF�m���l���[��A��(	�Z&�Bz��{�a��yS7�<o<)=�#-��fWW����۶��^��MVy�6E�yqΒ �)D޶�iW�r�b��$t"tbt�Qr��{�-9��]ެs̨��Ǭ��m�̚�����&�:���l�i;��$ֳP�3��k[7^��^�X6ö�0�ѨP��Bq[�o�2���"�����bͼ���k��"����ƻ\��]LF�,���0^���(m��r8BB�a�H�Ë�k�ʊ�)*�MV48�$�N��]�ϛ�n�ˇ��s/�wEV��iCl(~6�
��ʎV�*k;��Ϫ�]'(uƉFGRq���%f�?e�
�Q^�̫�=����U4�2�����n����y�󲮼k��"ǎ�YșI�e�0U1:֋����飣Pk)B)���z]W����`O� ����]]�`�֓�{�ge����]�_���6Qlf:�Zz�S�ty��U��n�8XEF+����.
��M��t�-~��h!c��C]/ǝ�n�����-=��,��LKi�?ͤ�����=�
C�2А��"�/�\7<ٻ�\ԋ�'��������~��,N���t��
�,�8��uÓ����m��B�����5���g	m���y�'y��`_�^L���߳u�͚��*�Q{۽��˦���g'�UE�����>�����u��xF�$�����)���eI��!/�mq���~[x���k&:�	A/�������	߻��]=��8H����DIr��k_�k3l�C�̷��c���|P��R?A�.���W���ϪG��p�� �����D�7_��'�@�2�E "uNz�Xl����ue~�ۭc����:�}h:��d�-14�������#��I�46���v�eږY7.&�a)!�(��.�v����n2(�z��T�8�_�첊ߌ�e��e]����}��/WM�g�,�p$�-7I�V��ź~���(%U���ƈ��*���nW�/�c�
U�/���z���?����c?l��X@h�	�nn���~��z�/{^�X��k����]�e^A,�ʍ��5�ںj������fKi�L�E�E2<HH��e��b�Q���5��E8�[�ؒ��<k���������0a�#����{U�j:켙š��H��wv�&]ݦ��(j���$I���J$'�{W/p!`K_e;������/wu�.+>���?�L[�64���a��w?��i��ˢ����Sn��n�N��b�I�}�,�
\z
�L�(��wSB}��>��>�M�$5��Zy�9ߧЁ�������D�жɅy���b�7@ �gb�/�7Mn���ۊ�w�s�lw�`I�NBZ���m���6���3s�H�P�B�3�I1d���|�5_z ZPl����eY�O�r�O:�P���l��3�&�M�	|u���W�4e���gr�	��k�nB��I9�C�0����6�y��B��7�k[ �w�������*+�n3��;|������b���B��1)��g�����-� 4$�K���!l,���:��VO�����&{,J��~�ˑx����Jq��Q�P�0LQ^��^��ѿ>dݶ�Z���M��\��`���CkA���j����	��7_���2�Ǧt㢚&�,�J/�##*������=ro!�Q迯������z����跶k�@q'�q#�Ǝݧ��r�U�F(��UV+}���+��l�D��M �P��������<_��s��Y�+p%��t3}IsH�c1i|\pp�§�h��ԋp'	%x�*��g�?�o��������_� �^E3���m��J;K��a�� _p���@�0�0%�Xd�C�!�����F�����Gx	��T�ك=����c�.�Jb�m�n�6]��~ �?���810��"ࢷ��,�*`��5tw���_��Zn褐ﮀ!����7Ee�7
a�̦��v�b=�ҥ˺�&.�@a; S0��Q���������ɡ�:��:G �%� �3�
 bPɒ�(<'�0A����v�C>�A�K+���F&����BZ
�����_!L�2@b��=e�ݧ@z�s�9�Te Jc��?w������r'M0J��	Tt!'�t�-��!]C���9�[�����'s%��dQ��˅vH����R�8ts!O���+��N]
��b�j���ֿ,	�B>���
0�@�u�f����~ѷ���4qLq!-w{�[ XZ� �\�@M��N��H@vr�����/�Q9��~8|&���|���\�=̣��8H���WA	b������{G6%��È�b ��~�7�qO��A�� ��;�1��6 �o�����Ciq!�Bz�i���������������f�rH?���v�!��U ����4�M(�4� i�U�-'���)��9P�� 2�����G��$�
"
�G�k�ntbK1bD��\O�b(|��?�Uk�I�\��g8�����gX��af.۬�A;��5ĸ�agag2z��x �v�P�Ց����c�a�<BM�*�AK���Ŧ*�$��ܷ@�P��YNw�`���6�WF���e?��4���P��(���RF �����E�a�ܿ��EZZ0P=�5��b�+�@N5��g<l�2���P�����bȊW�vx��E���qT$!켔����pw�~��oD�T�z]<����޵�(i�gQ��$�ŘP�0�r��@���7�1�Ed�G�!� /��#. $F���k��`n^�v[��<�%@+2ے��4v�0N[��[��숵�j��0�a�$�&���-uh�#N��g�#�;�����м7�#�j�?� @��C�0�^���P��� ܱQ4Q��r��)�9����:�a��%�랻m �����/R���$��C��r?lo�#�@�0����؝#��e�z�-�;H$�dm����qh��͛��?��7OW����LF���N&`�/�Kr�����'�X}��M���:+�~�i�q���Ӄ����M�?ʮ��"BM`��k;>���.�L ���G����UEQ�@a�ǜ�������Jy��KJHXI�dk ���H�k�R��y�o�Èɠ�C`#� .���j�r��� �P����Y;�+(�D�����0�GX�]F
�e!@�����#\���ު}�&	#��;����	�[��=�cG?h��$��˒��|7x<�������b/��<��y�U�`���fP:3�\��0c�L�M��� )�v��s^���t�o�9}��[	i��K��l��W��g�����e��-ź�&
f�n�r>N�i���/FS�����@��q����U0�9�Fs{�3�I-G�Of��o�GK� ��8�vΑ�Ć�7��
)���%y��`�t2�4W����[8�v� �&o7����� �����x��,s�3�kp�]>9�$$L� ��BM���Ϊ4��~^,s�J�a�;����s4J�Sݶu����k��"	��˷��&=L�}=x��PD� ��W�wXvٯ�'��l:"X7����ɮ��և������g����6Q����@�k�i�mG�o1�L�zRŲ��lJ�� ռ�b@�\>8�q�w8ir�@�8��ȀnA�d9��)�v���ޚ� �C:��e    ������K|#p�1#}D��%u�S� o���x�]���	9/?���6=����Q���U��F� ���l���[�l�fr����q���Zt�>P��&k��^�����m�@��C�7SXZ�%H0=L��σ�V�(��|�&_���J끢�� #�]u7�w؋����������_s��"ho�.�Y�]:�Wy��o
T��*���ҽw�IuI�T�P>-I|�{��a�&k���������`��2�ތw��U�-���e3�`�qO��05�9����ǹq�Izo��0EZ�bI'q��ƅ�E���	��#!��X�pYɕn�%)D~��kQā�XC�8��VD�y�w�-����0;3���ۖgs��t�V�w��X}[�u]<�7�y(�8$0WY3A��S�e�����|�ϵw�$&��n��)��~����i^\vG~�	�~�DN���iN�<�]Q-6ىA�b&9N���ذ7t
���U�!�����X9��|Έ`�JF�dؾ�3�E��a��$����D��qa�6َa�}����0;4:!��4���v̿��:��K(1�{�����~9	��

��qz��v� K���3Հ���I�b���:b����� 9J�޵��y��E^�����	z�"�-#�]��a���&��~�g�
��.{[uD�V����ĉ�}ծ	��{�������?��zp�W�`7��|���b�ip���D�i�*|Hwppl��bQ9 ��P!�> �2��%����I�o��8��x\`�l��2b|w���ji���3L8�<�[���B[Lu���^5��7? e���`pۏ�Ž-�=5v��\��E5
:0���q@˜)������F�h<^hK����eA8@�@�]6�c��a3h��zN������%l�h+	&�3mxz��hgSc��� ������s�eBk*��qC�s�5!����~4p�ʙ2P}P����Ӷy�� L0,�9!/��Lw�nwd�*��n\��sGuhL�G`*�gF�x�a� 8�`�5��n�F���⎆�֘^Ы	��w=�U��%	!7��ׂ�p�N���:�G��N23^�S�0����N��PȘ�7B�aK�FiO ��}-�����hN�_?C��Z\Ǭ=��0wJx�-g"�Ѥ�R)Z�$��&���6w� D��Q�_�wVv�\G���ʤUǽn� NB'p���gw��LQ�/d��Fv_��}�Iػ���������;��bs�ސ6���7� =B�!9�Ǐ�?�YD�zq��b�pC�4K��BO�7EW�G��?��0c�LB9X":؁0��ox�9`L�U�����Kɰ���*��I5�)­Ć�$.�c~��P����2��~�5����1&
����	�5�G���@�v����ϋUc�t���$a$ͅ�|Q4�a0J�7���},:���>�W p�P92̈́N�E�8�\,�o��	B�.���].!���z�kh �e���Ԧn��� ]8�S*�������'�����n99��d;��Q���8�S�?��}CUu *Ò��#���Q;I�%�I�U�k\�L�p�{߶�"I�C֓�M�N�Hj|�)w��~�O�Rd��B�����/,�碭��M�u6[!�J�� ���Y
ԝ/q	���g�� 1��QI�/��F�ʼ�/+*2b`�W��U�_�g��M��q���v�*� �,��-�q"1O�eVf0r�ӱIe�M4I��P���Fzh�hB���(~8n�f"p�r3��6����b���M9�0@=HdI�"�f�M?de���ϺMf]�0���iH�~���	y@A� �P�Ü��҆�d�k	��%����r1��[t��6��*����S2���A�т+SUO�(v�"O�u���B�2�W�������	5.���½��+zūz_�$�#T����`�Ȼ��p��fg_擏:I�-C��c5���l�����#��j�9,BA�dV��6�~,h�Zb�	���b{?N"��&�C!�<m:�X���"	�e.-kY���"�铇���~x�o��=�s;��!I!T}s�}醋��$oU�U�!���ܘ�F{UX<� �~�W5���m	�����gp�H�,�PRϠ5$c�E.�U��ڑe�V���1B@�$�H�cF���&8��M�;�bt��D'�>kaH[�b����v��O������3;��!��$Q``h��>Տ��#ϗ�\ѡ��[�?pc��˯��cL�g��5�.��6��R�d8D���R%�S̘�H,|�=68ҷ0bEś����2�4|@����U��>K*����;�(S��5�ۼ;�t
���u4]e���O�o}Ԑic�����6��F ���/ՙ���,����0�إU�eL��۠4B�r����e�).��?,j}��=U���c[W�9��%�A�E�1t��$�Jm�ۦ����!I$�T���vkW���p7��*��}�>�'��}9.9�n���+f��@�����N����g�p�zXwBOj���E9'B�g@޿����\A�n���nv���%�,>X����2�pq�b�
 �@�}A�~��������:k�z���S��gZ�=(,0(���ӟ�\�R�d���CP.о(��tk7����M�02\�� H�b�eAw.�rV.�Gj��� �����t�]�oF�@2�#H����`Ѥ%��c�@��h�y0u.]~����c�eM^�����dZۉ���:�m ��j+ڔmrk3�b! �r��2�Y���{T�� X�b]�lVA�&���`���e�Y|Ϭ�����P!A5����8���Rܢ 
��2̝	 �l8�+[.�b�����GH�V(���%���p��o�n�-BF�53ؼf�Ѣw��:i�� �ƅҰ�X/:��e=X8tf�Pt���s�~��1?�`�X��q#�l>�#�b��O&�̙n�u
���<Ι�PM��&�4�:�h�L ������dȂ�LTi\�z�f���@z ����ׄ^r+���`�Pw�ҵ<FCq�Z띷���ȧ��W���@G#e,����}k�_S��)I3��0#L2�ٺ�<��|��\2c0��<��s_؄�7�E�ܔrf�dX�C�&GX`��u8�'�$�*��4 !ֶp�������eh�h\#�MI�P��`(���P�gM�$w(j*l�l㹝D<���W> �	��-7X�j��V?u�5g}n��$s8T��h+0c��{��v�r�4�Hion�n��!�������G�k�b���X�fia̺�9�!p�՝��\�QA���c���_��l�}�²&/
(�[�Yd�.��Ŵ��B| e�����=���� �B.!`�C���C3���� ����'�ݼ��rg���z1��.�|�0�
B����8������cXQxw�z�oZ�_RSޕ���U13��Wh�k�ɤL���g.چ�5Bh\^Xb�{t�%�&��wEN�	��_�]��n���ܿ�x����ɷ�K�so�r
a����zV�n<lC��*`u��`�T�������V� ���Q�a/�����5�d"�G��v
����P7�	&$NF:����D������M�H�&Cx�+ς��ػ(�5�D[?԰"�e`�~�*�t��Y9�+�����0�r6����3�=w4�B@�؎Y���%�G�Wٸ:#�ϝHL�I��v�f�:�k�^� gr5A-���19�.Z]����a��� ��I�f��2�A�A1��#��Pi�v>�H��b-c�z4%܌�� r���v�(�D���{Z�H�_ �F�h� �!���n����jy�e�XP    Ǒd*<e��f��x����>+�^�@H��=�̻�$��J�� ���7��<2K� v�]{��@�E�M����l��ZB3�A�f:�h����c��x<�o��S�yZ/�q�BPe�lB�S&��C�Pج�	��{��V(�1�|�Lz\N��hGؓ��8R.�y�|�ѿ�+ d-L��!�C���IL�'�r@��Ĩ�>�C��?���+���~�}c�l�B.��^���z��R��C,,�rI��t<]�5d������(�C�j��������S*�����K�x�].�2a�,�����\oly�O��Ê<tq���@��u	u�~�sv�ZAgF���+��f�C��%.�x����P_1�-t��T�벴��&�	����zG�D�]�����S�lh(E�c%���@�N[h�.�_�x5��Al��&�uS�6��a�#��
�$9m����p�mn�#�?�͜��Fg,7�#$����PA��E�P �c��5 ֩��&��C�n�M�r���  @.=\,�EZ^�GwOe1���{j5��b� ��	�cH�s\�1��jk��w4a"L?�(�*;Zޟ�ƙ���J$w�����`�?F4��c���v�O���$�:��j8�B4��ގ�[.	��-��@�����(��fnkox� 6�_0��)�V�������Np��b*a��5��|&�
��L��O��U����x$���xn
���ψ�̐38��n�@��|n��M���jz��ĺVB�b�y�A��CW��t�r<&�wU�`7�򓃙�^�?�퇡�J�b�J $�!��  �.[��@��ӱ}����g
��<&C|�:�Z���0[j�s��YM+Z�;�Ȫ"�ei�����9�Vힺ����լ�h���Mޟ;q�XdB���I���\z�P�� P��R�D&\���v�
���&u@L(Sl�)�\s�x�X�SWv��\9j��Ⱦ43��jd���E�,�eUx�mx{�ugڏ��ږ4A�vs7Z6�"[�t%n��*�X
([u�vd��	#���y�N`� ~��L�?�20�YL���m��`٦2�	��L��y�P+J��g��k�e~��c�j�}%ֻ*�]�t���X���_�vn�|� H➊ I��$�Hr�H�z����/��}\<-iZ��W�f�Z��<s1G		�&&�-�O��>=�S"B�Y&��d#�����u$� ��#1�gZ(�!"����M�}�@L
شa�n�j+�QhJ�*a�_M6��δQ��bc�X''&=��f�{/ykX���$��0Q��c+�v�Ye���Kc��+
�4���/q�XB=�h-��֖fT�-��|[�8#Kͅ��8�����ρT�(�3l���v���%�ÿo�#�S�Y5[�RC����e����`�qM@���s�c����E�u��0i�гӡ����|���u�lI����,V��> �[0��?����քŚ1��-�v�|L-#8��������3���!�1��v�S*@��H��aYo��d[n�˺k̨Q�r3�Fz뵝%
��v�˰|��3Jrm��n�
\�V���d*��xj�R�������}ti�0�̈�i�n�Y�p�K�A�:f'�po�&���[�5ra��D�����aM��y������MZXEƆ屑��"�Dn���V`�M{�ȹ���*����+��5��Ϝ���]�X����+�|�W,"� � [�ODר�f��l=�� aL�
(G�����#ȿ9���c���uV(�}��v�o��	/3�c�%g���)���b	O����JY%�iS�`�*{�]\��8�o�zW�J���{_w��u�Lu�'�Gʆv��.���a��/³|sK�p�6��%0uo3�WZ9L��_���q
Z�ZJ% � ��ގ����E�+���YqӠ��Y�۫,s��ٲ �˪�KL�м>d�~��f���{��ߚ�!���T��ʶ�H��dՎ�D��.L�E�݆|ݥ�C��#���9�e���	��q�O(^�0��qo�qtd�O��Hk%��͠<��+{H=sq6�Ɇ6m����_���/��f�n�Xr�H���� Q�B���vTW�T& {�H`�]^��
φ۪��[�#������)�>H>��y����U�qV�ap����tNM��hf~p9���kaԲ#}/��d��Dl����D�Y� ���+Z������R�@�{��׈�99���P���G&�U�':���ȵ��.
����7�m��@�q���a�h�2X>�F���a����ޫڤ��vt�X���̌>��>��@&�!~o�t#��� �N�s8P\fhC�������w�6��nslpX:��җY��e7Rrk��Ay���FotC���h��(�����8h���EO�[Y~ ɝ7	&+K�5���u��9�<o#]c3�`'!�G7I�:+Pd�hd�m^$��)����������� K���N���s��GĹK�-�)Cy�n��D��<)D�	�K�%�����p45���Hl��b"^�=�MҕZ��)t�m����Y�	Y93&RŢ���N�~h]�7L�V��ǁ<+V�=���R �J\3�AĂ�qxT�@�u6�@F�C�:�l����W�no�����2��y��u��j�X|��*~�Cg���Ĕ�a��0Gt�<�	[�(�"�I mbur��"�y�b�-��w)��_��?BYo�}�=v��P3�����mS�Ϧ�
�$�Zؤ(�i�����l�����w�`�%맫���^?@�z\����`k���G��PE�y��@ǀΠ@����b�{o\�
Fȫ(��|��w(�`Q��|#[�
3Fp�j��������b�i���MH3�`m���X>�4��D: �g�`��g�DVԦL@�p������88�X0Y�ꑉ�X����q9�/Y@{`�p$�>��X������n��&k�Sj4�#[�A���:��B�v/���#~ �$��\��uv�*�~>�C� ڬ�(t@0p��!g�ͻ�s=�k,�B:j���M��vׯ��Ce��x�!�]*��vc�܆�������N�Su�@�X���������##���X�Ir��ї3f��I-��g����������bz��*	��l���z��Y_&��������&��tU=����4�V̔ƚ��}������#no��͂8�Oǜ�J�<�k��_�7x�-�F�75�֫[�����>v)�t���ޚ���8x�m�+���[:���Y� p��e]X�&�����SdI$w�����r�?��Sf�w6� �"���0�HbR��X����v5x�R,�j�nlԟ'�b��8	2e�:����W}c2�C���n���{>
�1ާ�>�+Rz��qhY�rֆD�X��-01H5n?���I���B���X��0�y���YG���%i4e� �B��1L�F��d���t����T�K�eG��:�ۚ��.Xa���@+0���Z$�W޺��G_Ӈ�T_	��B��3@0.��6�6E���~��5��V,uVf� f����_��t��dI�<���
��d��,(��X}$B("3(����_B��6C��TK<]���_��~���4v ��2�.�	Z{�'zLYb\�Ao�K
X�M"��UD�uW��ʅ�`�e~�Z1��(����-k�/%�PH��vJU�x�.\� �l��s)�Ѕ�a���=�[�m��z�� ��������Z��ٺ_@�=�$l�X3o�HN��010��*Тb�qn1��n;ǹ��	�������ޞ�	F�;�H�®fQ"]��GKI�ʗL�Ol�KO�+(]z4Q�� ɬ$f�b�N�{U��l�_6�����Y��-�^db��q'����(��W8k�D@M6Kk�*�׻#��RǠ"3����    ��	x����G�������1Ƀh��T���;��L�)���\�TO<N�̶5������Xh�͆m���-�~VݪB�sm>mv�@�4�k��V�`%��[��=�3�]cO H&��'O������z��;+�H ��Y4���	T�f��Ѻv]ȇ= 0��e@7��Kg)����n2�����Mx�k=6�!b������s���_�������x��1�y:&c�j]�I�����|v�5"�����1PU%�[l�����%�]����s_��8Z��ۍ�r~��e�fP�,EM�$fb����˞��[��J�tc�R�(�����M%�N=jE�:����[�U�,�A�\�H�4*�$�X�������5��#�g��ػc+�c���"�e׬&I����U�����A��q��K,���aa��y�Y_7�
�K�o�_��|<6@鏓���m	�ق�;��?��
_$/Sx��L�{�
 ��?�	㦆���r?�[q�/�$y&��,dS[;L-���1��� ^�x(O��ĺ�	Hm�f��pil2:��R���086?�ynP"�fU���	�Z��n��5�� ~T(C�bI��>��%}R%�� �.�hy����U��g��M�=q�TC�	�ٸ��#e֞5wc�� h�П���"B�ָE�2nj��Հp�?@Ql��[q+X��;��$j�#ǃ�v�YJ���"V7�?6��ç���Vi�V���6ɲ��!';�$�P;ܶ�p�N���H 1-�0a�~�EXc���l>/�]`$�_���A��CK1�D\	4G)\�/7NmΒ�e�aB�K&�$�3
g�*��_��c9�b6�!���{�]m��g�(K�BP#�Y�)T��m�S�(6��󉼀Ƴ���cwEu�I�ALvw(U�����%"�V
a`3F�E\�P��к��>�
`�S�f��S\�Hs�,o�.�MmK���	�x�/��1?��Lf`�ǘ1�AmSH������	���(��Ź�{���sf)=��ǡ+C�ۂ��$�<��if�
�>NS����U�* �@q��q�����c���u%����6Oq���#f�n{�T���i($;���v�	���Hq����e{w�d$/5g�L0u	3�Y�Q�Ӟ�*���Y,`yY���Jw��˴�*N�d�R�Z	�c~�7(-�o��A�K�cjβʔw������}����)�ż?%�9���`�z;̧�t16V�6��A̖�w���
��ؔ�:#���±{Rb���*!�duʚL�;���٨|=T����SQ2�`��[�������ei�6U3�8����'1Y�oE�t�؇�0���np���c�U���v4�`X��a 8��iC2�\2�o{iR���rVg3\��.a�3(-����Ƿ����d�IW���f��NYX ظKQ�-���!�~O�|0�z���������ԁ�DʶԈi�7[҄v��`��K8e�߈��WY�B�~�L�Z��goOL0 `*��s���/����q�a
�A��)�%C&�HDWu��s2�|��S����W~�,��Rwe��6��;Abơ�O묰Z�E�jDDQ7�DXl�W��G�����'H�i���Xqfb6�d�����;�p���x�醎 p��m�-J�MjBt��`�Bֳ��u(bh]��cq�=%�Ǯ1ٶ�Q�v�`76�j�JI@\�P~�V�l�\��m� ,�1� ��-�*oq26"�& .�0�������F��Ѐ_��Z3�����J(�0�q��cn�kG��%����l� �1l����1���W��uA���U����%³�'�G�ePdr4vW6���$��<��l�N��f�����rv������dVDL��B����ok�B�۳���4�/�ھ���׷M1��Կ�q�Tw��T� �`Po�uK;O�ЈYk��	|����S�Ի,��6���UY\��ĥ-���9k!�SNIⶄ!��
؛��q��v4.
���n���m�63ʘ����k|�����"2(����w�OȪ-�2_2�i�k�>��8k��J$cp�H@��b�=�j� �f�"6�c��j��b����3o���ǧ�`�C�4ղ�l��f]Ы�bn'�e����ND�0��C>vPi�1tD� W��8�@���A���+���~�k���1EA�z'�e;:�`w�{����a�C��XC��/?ST��SݳҤ�[od b ���!���}S�
�}_u��
�3�g2 z��ǳ�b` ��r`p�X����A�u��nw���"��/Zۆ�]I����m<�7��tܜ�'�[���U���n�8~ֱ�Ͼ`u��m0��n�W,��_�+�F(
�wA�eF�C������8a,�$�'�Sa%�s;>���g�DYX|}���U�̫^d���������x�:�]���~��&�xwX�3f�Z����-%/�$���?�m0k�=���Y��}Ǹ0�Z~l>� $�i\|�:,F��qq�΋3C��R�	��N'��=k��k�tR ��<�>��+f��7�}4l��Ǫ��FWO�c6Sb7�ӔR� �@�>�xi'��t_�"�\٬s��z��۹���#�ʵ�fJ����0直W��2^��5̒�Q����<�b�Џ�-�݊n� ��Z��Y�]e��͓M軞���S��m��d�'
����T�����p���֡�6�B�|�v��s6�B��̙Zn'�Ǿʲ�a$���n�i
��	��1�>��*^����<3�a��$�'~@����w���\�F��k����lCp�x��������o��3��%9�b4���q�M�j�����Pt|C��8�o�_����om�`Le��%��A}B˴'��s-���^�pd�z�ba��1#��.��K���F�c٩M�H��ٽ��1׬�iT���f����T��j+���%n�x�ۊ~���mƿ�q�O-������Pc�vN�pv�n��Ǉ&Bz�����4���j�h��at��z��b��}�qM�*7�M^�q��.;[��|�	�~��ޏy���e��.�����qt\����h� XZ2x%�r���UY�����w��/|�����O��b��$}�����at�D	(C릈��*k]�˹&�Ui�x��յnUϏ9�9:¯p}W�N~
ڿ���a|3�yP��2׵��7��e9�o�v{dxeD����J� ��W�]̷aX�N��(���|=RR����`�If�7��?��q�v;��Ե �۽ >h^_���궀eXnXE��q�Κ�g���ڰ�lby��n� �f7[�>t�ob`�����S#�[�/��W�T��Ecw��Q�`�۲���T~,��@��)8�-���@���~F,'K��Y��/�M!˛���9��E9��DcW����>�u����g4"�bc��5�0a\��-�3��)c�� S�d]��}�������X![���|O�O��.����}��'�v� ��3����b�h�JȽ�,V�gI{��뚚u�b����U�|u� (~�<A���~��I�R:k��_R�Ly��J���k�������)4k�G��^���F|��|�#�:��X;۾��08<n������{���.�X�>�Gg��E��n�$���bk�o������26�o���q{^�����	�Z�=�(>%�� ��K�dK�@`��,ځ 0��i�e݂���|���(�VT�T
�l>�w�a��c������鯛�¦�Z��˥�ޫ����q����W}7�^'�$�s���N�Ϟ&b�zb�8�@�XwJ�,��M[+mB������л�nZ�.Jk��y^~G_���+g��R��f�
=L4W!<9��/�A�ma�m���O�4�6�������,�f]��'H�! ����Ǵn���!�^�t��^U)^m���ƶO����Zz���~֔d��{Yd���zΞ���ج���8�3ى��y��    S��e�@��o��.D����mȒ-�b5f	�MeqNܟ���-+�ƾ�2�����k�n\|�^��!c�p�y��Y����sr���eE|���xU���ӟ��'�ɑ�1�ؚsď邾��u�e*t	5
������׃}���p��N��ԧlE{9��ٱ��)1n'a4�b�(��.��tp� �Ϫv�!ċ�;i��-���k�e��b���P���b��>.j8��ຑ}p|�q��:<�:BF%,�2�����3����~��n�%��P�P������7���ABf�&�����"]�샙��}z5�90	$:���N��%,���7y��˥��d$���ϛGD�Vk��eRG0�9�m�6*�C;�������L�X;�p�y+���O���G���M}�@�.��l�t>�n�)ذ��+�wEW�:��i�em𲭛GG��;�JE��	�G�N������6oak�����I�&��ş��S_��jZ-mk#>+����h���
�ǂ4�6���_n�W�X������ȩ���[nߤ�֧������S\�	t���Ru�ǧ�{l�6D(�������� ��
H�r���~��ml@�׸��*o����N�Ţ?�63z�����X�iOq�q��m��P��N�$'2�6�������|7�X[����f�C���w5a�P�'�;h��J�}�,ʶ��-���� �m����e����6��6��ej߉M�fGnv8XM���Yެd3L����?E�=	�>y�l9�`��g�H�!w[�nw}s^����Pu6Π30����ذ��; W\C�kX�]���(Xn��u�g��X1�ʕ�+�g��}���ֻ�Ҏ��oJ}YK����/ϩ �������&�@��A���)�vuL�t����ӟ�������M�3������r���f
�ؐ=P��V�]�^B"+F06�8�7w������=,)���^�ƒ�gWz	�܏B�]I��,Ԍw�,�����r�B��j���j�ŋh��S_��l	SX�7o8Z?/T��i\[2���v��l�+�Ek� ���v[�����Ћ^�A����
��G��3���U��3(�Ы�h�t������Ć^X��w�pY�n;9���j�	���.�埲�%{ݰ󋖴ƭ�@��c~���D�#�4w�:89~G�i��	�w-��+���_��(�O�v�ϵ0�>ƃf��r��z�.����e�3�"��dRGLǞKo�f�@���u��X�:j�G؛�qj��S�g��@];�����
��Ά	t�7��-۱L��6?��,�k���U?�!i�Q�I5A��m��q3u�>fj�׉=�;��O�٦��-0`�n,*�X��BC��bI[��3�F���zw&���٭Q��=���_8\o�v/����1��iƊ�k��z����r+�e4����lh�?V��K%LȊl?4�mJ7�.�y����	���֏�&my���t:�B��B �S��ϹD�o2 @�g�iҬ;\dv������:	�F����&�r�C�ztQK�>�Јݢ��$��\%��6c!t�d�������@�)t5>���_'���u�b:���|dF� � �b`�O=�]���_�T�������T�̠���g��q�Dק��.�(��6WǺ���n
��aE��{>=��G��g6�l��M�@P�I[����Y� ���a����V:u��[�lY���1P��2�����`�������1�8��if��л�Π�<���Ͱz�qyc��%� yѻ��)���ݢv}�����ܰ�q��	���s�����t���;
��1#%I=%�=�6�"�˙���%��D���ސ�G�Y���b3�hPP�0}�v�u{�f���O'�a\���
�}7jK�ɞ�|��nC�:�����7�P/b!�Rl�4�K˳:P�c6����B?a�ɕu�nJ ���ti�b��TE�ݻ]_�㞻�A��Hh�d	�{;\�� �'hT�\�_p�����2i������a�k�-qMw�}�d��c�Բ;%��!�S���yU=T���+KA��w�X=�.kG7�
bA�Ç�7L	9�~W�'<;��R�{`b�bs�>��9hŉ0�"�R,��z�f�[�^7,]w�w�k�7�Y��)�������D|����'k;��J�͜��H6����OXڪ��"/�I����(`�e��ѩ����7q���"�R��C�1],��|�E�I�FXS3�f&���r{�C�
6{R��lY�������?N���>|1c��{o�3���2��M����o�ũBw������e^T���X�N	Ba&L���»�c�Ŕȯ����M�[�ꆛ ���FQ��n!h�#��)\�[0V@����W��G��9�ʩ�S3ך۵^��[ ͞% �,��K�����<&dI��Aѽ8{���0#��=�ϰn�w�ҶC�[�����P�7���y�)�#X��m���$�'	��Sq޴���ȟdB��2���s���r|�Z���.��*�j�����lqҸL��4���5
|�,�.��.���D#-]�{�\�dO�ch`خ(�<�@Ebw#h�/1��������Ȉ��j��C0���\��� P�no+�wy�(��gD�����\��o�P��èb�LF^��su��_�g�>K�v	�WTf��U���vi�8����_o������ߖ��@�`g\��8�����e;��y�:����=�D���>���3{ߕf8�;���ߔ�k�B���Ul�x0��ec�(��T�k�e��@L����m�#腭棓
���Gv�X�S_[v+&��r��Íy�ZĲ:6��r��w;�?�="��b��=e5�_�����v�.`#!IL΅E� yi�oL���MGM�5	��<%���fIALe�����2���#�c^��,��kl�f4���0�di[�B����=N��_NV2\�a���`�L��gߪe9��D$��M�fz�-_���� ������7�'av��v�A��),����,`7Sn�P�T�m���g�î`,]���[Vj)��k�}��L-��$�c�~�9y�>3j�=�,mu4��ǌ��- �:�K+��E�%���=���f�.�z?�����Ja:)e��ew79�$��m���L �8�Պ����i��}�q��}���uѽk"m��YL�2q#�<y�"0 �d1�tiM��ƚ^T���(�y�����X>�gU���RPAR���ì�Ő�b�p"�T���࠾���Vo�ns���=c�����*�u�fq_qƺ4�^13����f��+F%O��B�Uٹ�V�f�K��P�����N�f�9<���!l l�V���n?6�ɱǶ�,������N�? ��9�hi߆�3�,��m��#o�%��ӿ����iQ�=ηn�����^���a�i�Yz+/��dW���lW�&/���l��G��t�����rSvKvJ����8���{}�#ˣ�c�DO��]���?ab?�����(�7�`��1,��{lm4[���Y����K���0��~�#c)�K��Y4�n�ҥ�Sz
�)2{�Uy�����+Fx߷U6o��c��XgbBKxٺ�����|v���:��>J�$]��'�L�_a��Ƭ�鰕�#�t���bW<����ĎV��y;����_�[�$IH4�.�����g�>՛r��nVcq�U�f����m���K7G�xa�sfP��{h�`S}�B�=*��5_P�{|4{೽e���:ȅm�rV�������M�(�/�H���͇������$�O�.�����54L���9m�����`��l�� �溱u��e܇��o�CG��GE`_9l��n���DF�|CR�����?y�yLI.��	���Y�ܦ�H�%���%�o1|��D�a<4(!Ǒ=d6��6��֌So>�B�I	��%%��e�꼲S������%x V=�d��XQdޜ8o�9�-���    ��t	���|*žϻw�M�BE�˩�a� ��
�KN,��@ِ{J5��6�â���?�� ���t'是�q��lsJ���ꦡ���Gٖ�,זa2T7�P1l�Gf�^Mn�'�vڍ>�-���#f*�j��qY�'�&�?0�|G�B��v>%�1���r����il��A�/'�myY������T"e�y^�1�,&2 ,�Б$E2�>�}���mg~>�`��3�܄)�|�o���u��p�"�x^?�%�E�r������b
�l���eDJ�ԓÛ����M��ֶ�E�6>�k\S���Te�Y�6{Y��c�HG��)|��Nc�������*]'�o���U��X�w�OyƢ/	�$��ǩ[:���vA�aI6Kg�8���������)	ؕ��$�ր0�B���/�(0��Z�S�����λ,mBú�Ƽ�q�;�Z�b���3��g����4�Q|�>dW^�S�����ܳع�7�
 ��?=��2a"�s_�O<O�5��Ti3���y����a�_�t��SK�O�C����0@�� ��e゛��濯��/�;��u�ʍK´�l-��&��b:o�9Z;�4/�n�Bxk�d�g�ÞR�͐{�_�<�R��P�3���l�8���~� �!�Lb�a�?�3b��VXm�{���L58�J{����l���m�����|��D�L����R�b)��g�͑������,V�r6�K�&m�f�cӸ�{�V~Ƣ�/�_�q�m�֥����x�n�$�{R��@���!]*�]�b���Z�J���PLL���e�����ې�#fQ(fT��.��D�m����e�{�1ۏ�se�\�%�'~�*�[��O�Y[�C���J��7H��������,/��$��v�w'��ώ��¬K�2ּ�Y� <@1�v1Os�"i��3p��}�*a��X���r1�u#�ك=�:|�M�<wDV �Vk�����XJ76��������U��U������E�47�ІL��m���D�I7�||�;�AI�P@j�^�/�P^L�|��b �H��/[��0tSaIjI	�J�}-��iF��M�\2_�4O50Q���ۘk�V����7+���B��NN5��F�&f����[b�����~��'٘���fI
����'�z�4D����nc�O��"l�i�'�!=灞������3�b��(op��s%s茮45�ZhCGZ�P���g8��3}�c�j�1�H%��g���³�@���jg9K#�U��n`��5��S�!�4����H@ 9��@O��>ҭ��N�k�����������SՖ�1݈儏A� ���͑,S0�lq<U��O���[������c�W��dʉ���J� +��g�<\f,�U E޾us$y� P� ��OXD`Ó�)m �Nq!Oy�mj��4��#N�PC`���v��P���}�� d{(�ϷÓ���N3j[��@f�l��h��#�mc*���2^yR�x�;�ٞ[�OO��o=fe�U��lپ:�N�𙓌GxVCc����,~���-P��;���j�{�b����g����:�阎"-����l�|S��y�(ʀ]������N��r�\��iUФ����ӭN��_�Pt����h���F�sd6�'ųN
FhaDb� ?���ԍm���Eu|x��5<��Ӟ��.�z���a��B�\axr�	��cS���v�
 �6�?�*v��ws[z{�U?��K��\)�y��2�qa0E�q3$�4���bgk%�����5eǼ/�-�6�.-΢c�=�3/k�c��6�׋�v��za����6��L	�@)=.���F��D��O�V�t��w4]�<gDt#�|��;]-�n�e6Đ`d�� �I��v��~�9ֶ�N�=,�C�N�α��m:P��)��
X�u�,v�`ص"f�A���{�Iu�5�/��7	�t�FC��Y�|U6[l::V���{ p���٫��y��^e�9~��6���ŞS$u�\�M�D���źҥ�_�ґO@)�#�+$E7=,~˻j	\��ֱl�	2�hA{@������ ���0ǚK9�;�?Z]b�J'�m^·�rY��� 3����5�6�du;$,�vt����.���$��eU4V���vQ�.*Ć�S�5 יRޫ���>+Oa�7+�&�l�DI��/#�!1��#�" ,%O���c�+؇ڼ0�/�]�]wz��n=���_�#�ltL�]���=���=�*�+�&�C�s�b���3x~�K�f����E�S@�/� �B�W��?pЬc[X�M�4k���,��뺖��,�f}E�@|����dIe�]�5f|d&+�d�LV*k�ݘ��W��]���`��K����9�_Yr��0�`%q�瞃�xr�����Mz����g~�zg����K>a�[o�5��	N�a ���f���Ӏ"=�|��+ɬ�H#�L�Փ�^����Q<6�O	d�hv����̇�v��U�>ia)�E=�Z	cb2
s��)]gMJ��#��)v���2���:�~W<F�y�J��m�D�k�^���o���9�L>FR���J��ߞJ#i��%���}�+�q.EiV
�-����O�2�,���n�B}�}�T/T�X������!��H���r���h�@{��?��H���dpmr���:_�d�7Z٢��~�g��x[k�X}��䉍,�<��JO�+qUsI燤�N�@�;�R���&�&��i7��g��-�~c���$��-T<?PǮ<k����E%�qE^�M!+������0W�0�VC)T=#�K)@]$v��8��	�o=o�i7����R��vF�]�dat�4�e���F�I��O�
��E�<CY�m��~�_�#��ݬq��#,B!�	��iǁ�52��E��	�O*j�S�����k�=�{!gc#��u��)��$��e��%�Th�}\����Y���m���@4�?A��(�4�}��h��J�o]���4�bV>���SyT��.��z�_�$TA���cB=�P�;G| �
�R2�P���|��b�u��_R8��B���!l������lMխ v��zz8/�,�Sv&��U�#	S��	�qD/�j͡�ɷٖ��Ӥ8���8	k�v�a�5׬9�*tqH\���fP��SsĔ� ���E%h��|�f���&��V�2�A_���o����A�}'�fےH�ȟ
2�k[O�)[f�S[�hO!�b���d����uS� �s:�(��11�W^4E,�&򳖴#E�@�$rG�7���b]��ZJ�HK+�F���ƻ��տÛ���	i�G�n�ܹ��x�g�*yw��ɉB�g�^h=d�b�����4����\O��6�[��h�"K!�gG�aD`����K$<��<wE�=,rx�pG.����)$vPD3I��<�ͭ8������ �%�/�S��I��! �<���n\��9��M�\��l6o�V/[��5�]��$
�k=��K�<F&������HV(:m���:g�F\W��ٴ����""Pxa�Ď�t1
L_�6�C���S���,�hK^��K��M�?�x�2�\)�]�O�ʺyC]$w�>��'��1�_��� IZ_2!���,M��V�*녾����&ю�[��c����6�:7�m@dB[�WY��m���a!)��W�����9�T���aуu\�7�R7����c:x�;�A�s>���0fA��^�wͪ�r��A#�=�J�M�cOY��0�o�C��s(^/Z�(��֫�야%&�����H����h$��6gA��*�ҫ2�z'�u� ~*��:;C�B@�*@���S�(Z�Y�D��N�˟���+�������]R]1�����f}��;X2�B��9���2��[�� ��,�j��M�|/J6l��D���m�
!�Vt�
�K���-t�X�\|�ai|��*� W�a�s�sU�x:�벻�H�H�w���c��    �R�U�f]-�I�}�I�����S��B3�|�4F�e>���Ŭ�SIp'� ���1�66�}R��YO�1	%y7�u"l9b9t��ŵ2�,�1t����X4�BJ�ئmp��j]#�D�$�,���=�,N��
�P�V�Vo��m�Ҋ����%l����z�w��5��ᆧ���`z���I#�c$��[I���f�T�/p�E_l���$#��� �c��DZ�iZ��YL���OD`>/T4� ��p��]'X�l��)u�A"� `�g���Z��u��rB�P�s�L�B?��&��ʛ�����%;m��
�͙cD�oz�όy�����~�K�m���6�<N@¾㸅n9�%�(�Rk'��_ ��kZ�����a> ��
����a���m�����5�N
A/"�%5�-F����X��	�0|��l�R�YQ?�s2%NB!ϙ'�߫"i�"-¡��$��x���L�Q��ǯF!����s���	Sª�oƧ��4	���tH%FS��BR�}�����;��(-�vf��g*\�N���E܄�L�+�_�jK���L��S?%���LX��XɠI�#��|e�m�r}�YL��H�
�RrL!w0 ��$�gC�[!�������F`��Vs�-d;�M��u6-ק�}�m��B��`;L��v���_mZT¼�z��KԬ&�����:�"f��"!�a���8�2h�٪O����3��q}�<6�
��O�b��x�|Hߘ��P&�I��]�����u�Lr�S��tN*���B�27�iC�	��$��;�#�u�-ǜѝj�C�ʏ���^@^c���b�&u�Y?${yz�p�����:�@��'K����٘��Q:ȫ�+�� �����6��n��(gO�V*'�u�cj'��]?�)�|��I';����ۏT���&ͰQ�]Q/譀�˼}�#��R>"��v�K�$��k��#�8��K�O�a��a~Y�߁:�w�3	��bpT��a�q �J�b[Y��Si��s��y>��ʷ'��9g�TY I�偅�"�F�@��i"ƥ.8����!+[�%��@��7��@SK���|�:s�H�Nr��������i��u������l?��� D���=b�������z�[�!5M]�p��,#Y�����V�U�P�n�^�*�axR�y.�0����_g��4���ZX�9C� ���}��o��)>(p]7DdFLP���\�&�ʹ?�G�u��(�B��6H���K.��"��7yE`�T�9��Ȼg���� �Iqc�eգ������>���������"��U��gQ�']	�X/��x.U��Q"�Ʊ���y����­��4&J�j�A$��DH�c�*2�}��� vdjG"e�ʙ �����P>d`��")@=�W��T%��"����JX��1�R�F�ܖ�&�hr8ɂg�#���t���6\�� �M�I�%�v(��!qg�9�5�+��{�%�+�MXZr]���"��V���x�/����f� w���ӎ[��8K�K!C�o��]��@�~H�\dM�%�a�R�+8�-lD�I!�/R?5��cB&�H�SI���fI��Io�p�d�mw���+� ϟ�i���\�#a/�g3y	�::oV�z���_l���޶RQ��|fY�O	܀�1��u&�):���ڈ����Qw�{"��˯՗?�_�<L�"NC�Y߳��q��HR.N&���S`+D�K8��]R�i��!�|�׻�.�3*�\��"šve�C)�<G�Uţ�S���e�3�޶�v�׬�k�)z����R3'�~ش�q	!�n;�A�K�7'�6IF�~x���H��8Vp6�=���!V7g^� ����$�Iƍ.E��rٮ��5���2�&�:���1G�a�c�2��^��	�E�2����O�)����š�]~�����X?�!k��&i�t�9Jɕ��Ah7��3a�ަl85���p�M<뀛����۪�!��D���!j�)0A��O�ut�ϑ�!���_q������(�m�Mǀ.!
م麝��0Ϻ)E��4g�7�~k���f����ƭ��<�2�iLx.K���wE���ق�<n���(��8�i�Z!,��.��/*�u�aDl���EZ%kX`�c�$ ���º�كt !Q��Ȃ@(���-���[�$,�+c�l���>aQ6ͧ�f�kP���7xuNՓM�ӣ�,*�ē�����Gb��N���&�diZ'k�P<	��4�$��O����Pǌ���|�/���l[�3 ��Mҿ�G܁J�5��SR`Gp���J���M�,+�!�.��v b��ݡWB�di9��ę�X�r��(\���!d��h�J���%����f�>�GSk�A��;�e�b�sK�5p)K��VR�G��0ؔ/����ҏ�{�e3s>,�C�@d�6���\:CO����Pou{��~f��=�������"o���W��>mg��LBH�0]x��ھ�#$�a�9�ZғV��{	�����#z}�𲩒��c�T[7��،@l-�Ac;74��P0����Q�Xۥ��Я���癱�|�
��C��]:n�碁A`+D7�C�vn4d�Y���iϴ�P���n$L�S��t����p��!��´��8)9��8���o�՟�$�\=��/��m�^6��������CA���#�s�5���͇����MkY������q�����U�Dx�B@5�)���r]u����^:'��G�NOKU(�pQ��R!@�D�=R�I���j;�=�)c��h��ڸԼ/3�a����lհ6��t�i�Q�.@$����鶤j+���)8�a8�{�pY�vI�߷,��Ԯ���.�PLaԽ� ='=��Y�࿕G:U׆����9P�0�)Q&�O��Q�m,r*w�YK�F�K㸻�)���Axd�e����$=Q��
��ȰNQo����7��zB�@�0b-�1!�����v�D����\�ͅ� ��p^�r�Z�ȏ�fۆ�PΆ����J�H�mѺ����v��u{nFy%�:8I�n�%s��>7���8�$�@vL��+��J��\�rg�q�#3*&�p[Lo��iA?uAH��o�)�.�v�\���-z>���I�;W�euO���ޣ�N+��#�(+�GX��E��2w��ʱ��Y�y��d/�1N�B�����&�q�x�侑x��M�x��E�O��}>��"����q�#렱0�;]��~4�C|OG!�3�6i�h{a�\�իf�c<�Z��p��͖�8��K!�	ٲG\򇒩��d��7��oJ��hrR(��tk�`����ŉ8\�vI>)h
&��p%\��A��QlS�`c+r����Fӆ�P�7ő<�ȃ�r���_�ϐ�H��k��f�,�0�HBst�p��+��1��'�\�'�K@�l�P�u����y������|�C��f���]�2�Y�	��l��ڻ�������4�x+,���QAt/���nE��ft'|���.4#�+��E��������b��|k4k�e
����[�OnQL��T: ���Ƌ��y�ž!(d�L'�!��g
ٚ�Èb�����R�Sm��0B��jz#c2�?����S�H�E�\*!^�]9���� ��1�/�,6: ��g�x{��9�IL
�9�u�\��e�����Z4��!˦��	�"&�x\��6���}Y��gSk�ٳ;����e�7�����P$��X����I����1Ts�X��&l"E��1Rq�#y5�Ь?�C�[O���{���\%
�#c9;S�o�ُ�"�1���>l���_"U��h��]����{�c}(��n�=�J9D���}fe�d]����S�H��aǓ�0>N.�Փ�A�m��w�X�t+���bH�IԜ(�a�$�6ɀl3�uH�0ϗ�L5�I�()J++v=��C�+A>,��n�"��O�Z��,� �  �I}��9�����Q>~�����H���
�;2��,�0NAI���~�ԛBN m�����Y��ZHސӣ�㑂7������fV	��"��P�7������RM�G��-k�B��s�J}�!M�z/[ew�'���*a������
g��֦�E&#ء�l��wE���؅ۂus<#q�,��vɶ�dF�>������!��q�@�8��l�lN�TJ?݈s8��5�Ez��F%��%ٛB���d�!2k�s0�$C��|� �A���'��Z�t��Z�!���|��D�е���D^�l������I5��+$U$��Vc���o۔dν�@��9L=�/�=1
�Xz#K����(�؜m�1v�f���*�����\��a>��0��X�4m=+�Á��ļ\���~�w�}=��=��wJJ${@�I�U2�3����H�vb�9&���SIIYo�T_~��\��˯,�~�o���m[��l��� � >2������ ��	�������a�d\vD@����i:䵬 �GV��d���5�Y�~�Z�.�y� �s�n�$���!!� b����]հ�� !v�X�9�u�&=	[Q��G7:�c������yy�s7�nd�F!a^=a�4|u�������Ki�+<1��Ƞu��;d]R���"�����%p3�F<�W�Lt���yɁ������햭�p(� ��.�Tu��c�U���Q��;��5{�c�Ǳ���gf��D8ٳ�C���*� 	3GYS�s�擇L�e���#��=i@��Nv�]n����$������]^�j�� dx���,�͈:��y����f���1?����� JJ�k��f׍�dKeJY�nD�0N��c�;��3)�7�w�_�х��|�+��!#}�y1�i#d���5Eʁ_�8�������$�����������'�rfԓ���?�l֯K��٧�d��ڡ�3�v`�`hf,�a�y��9��6?�PV�h΍�7M�p�����[��0��K 1�]*[d��J(���{8>���P� �_�! �o*)'���7H%���������]�D�r�q��Nf��a�Za�"�#�����X�w�5D�-ѥ�Ȟ������Oe�H�2 .ƕ�ńfqyn'�!-G~�F��ٽp|Z�Hr����x�>�o 8�YR1�s�p����W�T�Z]o��>w�����!�F"�b�pé0�g�2�k��&�M�ts�,�7:�>��!p�z}Of�����M��j��ɐ�fs#�q�W��{�ȳ�;~@F��6�a�\��Th���ٙ�_p^Ӄ�
���[�����)�����I��z���fow[�L�a!�N�n� �O��9/��u�H"��@;��j�<��/�����X�'�L�w��S��!��#�n���(�t��퉮Y���%�:A�pŞ��r�|�aԕLxq*k���f�������ܳ�K?�^�n���;��
i',����!-v���𲳺��;����1/
�zDda��g���>�-��u8b���%!e����| �ѡ*��ȇ�f��<J��qp�H��%)��&��X�;�I ج�G2¯���dDRϴ���r�Q�f�<��B�ɴ}j)y���mQ�T+�Ѻ�(��P���S�a	����#·N�yy�M��a��6<��e��HoG� Dz#��#�-F�K��w����ݗ_���Ĝ��_�H�}�*�����)S��崺�=�����^��z������!�N��T�}L,%�Ǻ��irHG��,��+�� �ǌ6!�v���ߚ#�u��0zr.���>m~����0�ל�p�e�ٛ��b���ƑQ��v�4݉	\s_�Yq{C���t�-�P!�S=�í@�Ā��'t��s�6����KU�qB�%Ā�����}� �-7x�\G (����C��`I�������D��#���蓻�E�Ǉ��Q���ė/=�7�_��"���L�bTU*RǾ��8��D=eU:���IG�<q��<X��y?�,Q?�K���5+��U���;��p̞0��#���r��l���_�dN7�b*�p;����Є��B�,+&�_��mXo��c �|��9�[�1��鹫�"�^����>�����@����Kr�"���eG���{ݧE�(b�8]0��2�w�]P�\%����x,u��R��&�<��BD�`�1M�3N=s�@��.?�Om}Kֽ�^&�]j���02�-�$��t~4w�"�'��x<�t�*����{�*d{d�|�w��e�<x���a<����'ŕ��,�w���h�^�M�+F���0����G�����8�&?�x�N>rg��nX�W_�{ {�5�"Jy�g+��[��8,���u!}*/�8�_�庘�f��XE�鈣��j��a��:�?ȓHz(����f2y;T�^7�:�K��-�Ṿ�\ﶚ7n,�D��{�M�v�>�͌ΡJAvQ\7D���m0�7�g[v�(\�m	!#ge5�}� �.������j�R)�|��,ϛ���4W�9^��9�2}_��rQ�0�~7�!�� ��%�����G�ע1xY��Vs�NH��]%{�M����P�#l�Ys�)UO�5����u8���7_L"�o�x72��?^�z8W���)��%�� �l{V���$Y��?�4@�Zgd�jG+��-?���o����\)�d���%x�F%L��`VMa�3��R�����2:�8I�±o�Í��;��"���$>�^��������^0T}BHw0ѿ��:c���V,��?�lj��?XH��KI u��dٍ����H~�)?&�G�[d��@*'Bq�D��FD�~*r��@H0GJ�*�N��Uq���f��@�wɲo��"���D���$!�L��\�9��N9T��e�D��4Ȥ�ٷ#���z溤e]ʁ�٧�qu~?�I�H>m�����W�������w��(     