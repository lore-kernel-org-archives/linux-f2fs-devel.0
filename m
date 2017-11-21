From: "LiFan" <fanofcode.li@samsung.com>
Subject: RE: [f2fs-dev] [PATCH RESEND] f2fs: fix concurrent problem for
 updating free bitmap
Date: Tue, 21 Nov 2017 16:01:42 +0800
Message-ID: <000b01d3629f$1c489fc0$54d9df40$@samsung.com>
References: <CGME20171114072951epcas5p17015caecd08127266436b5ef1bfd1762@epcas5p1.samsung.com>
        <002401d35d1a$5b8bae50$12a30af0$@samsung.com>
        <ebc759bd-ee8b-7bd8-845b-2cd9cb7c9ca2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ebc759bd-ee8b-7bd8-845b-2cd9cb7c9ca2@huawei.com>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net



> -----Original Message-----
> From: Chao Yu =5Bmailto:yuchao0=40huawei.com=5D
> Sent: Monday, November 20, 2017 11:00 AM
> To: LiFan; 'Chao Yu'; 'Jaegeuk Kim'
> Cc: linux-kernel=40vger.kernel.org; linux-f2fs-devel=40lists.sourceforge.=
net
> Subject: Re: =5Bf2fs-dev=5D =5BPATCH RESEND=5D f2fs: fix concurrent probl=
em for updating free bitmap
>=20
> Hi,
>=20
> > =40=40 -1870,6 +1895,11 =40=40 static bool add_free_nid(struct f2fs_sb_=
info
> > *sbi, nid_t nid, bool build)
>=20
> Need to use radix_tree_preload(GFP_NOFS =7C __GFP_NOFAIL)=EF=BC=8C=20othe=
rwise,=20for=20out-of-memory=20case,=20we=20may=20skip=20bitmap=20updating.=
=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=20=0D=0A>=20=0D=0AYes,=20about=20this,=
=20in=20previous=20version,=20if=20we=20fail=20to=20read=20the=20radix,=20w=
e=20will=20clear=20the=20free=20bitmap=20in=20scan_nat_page,=0D=0ABut=20fai=
l=20to=20read=20the=20radix=20tree=20indicates=20that=20we=20know=20nothing=
=20about=20current=20nid,=20so=20we=20probably=20shouldn't=20=0D=0Achange=
=20the=20bitmap,=20otherwise=20the=20status=20we=20change=20into=20may=20no=
t=20be=20right,=20so=20I=20use=20current=20patch=20to=20correct=0D=0Athat.=
=0D=0ABut=20__GFP_NOFAIL=20may=20still=20be=20useful=20for=20__flush_nat_en=
try_set=20case=20where=20we=20update=20the=20free=20bitmap=0D=0AAnyway.=0D=
=0A=0D=0A>=20On=202017/11/14=2015:28,=20LiFan=20wrote:=0D=0A>=20>=20alloc_n=
id_failed=20and=20scan_nat_page=20can=20be=20called=20at=20the=20same=20tim=
e,=20and=0D=0A>=20>=20we=20haven't=20protected=20add_free_nid=20and=20updat=
e_free_nid_bitmap=20with=20the=0D=0A>=20>=20same=20nid_list_lock.=20That=20=
could=20lead=20to=0D=0A>=20>=0D=0A>=20>=20Thread=20A=09=09=09=09Thread=20B=
=0D=0A>=20>=20-=20__build_free_nids=0D=0A>=20>=20=20-=20scan_nat_page=0D=0A=
>=20>=20=20=20-=20add_free_nid=0D=0A>=20>=20=09=09=09=09=09-=20alloc_nid_fa=
iled=0D=0A>=20>=20=09=09=09=09=09=20-=20update_free_nid_bitmap=0D=0A>=20>=
=20=20=20-=20update_free_nid_bitmap=0D=0A>=20>=0D=0A>=20>=20scan_nat_page=
=20will=20clear=20the=20free=20bitmap=20since=20the=20nid=20is=0D=0A>=20>=
=20PREALLOC_NID,=20but=20alloc_nid_failed=20needs=20to=20set=20the=20free=
=20bitmap.=20This=0D=0A>=20>=20results=20in=20free=20nid=20with=20free=20bi=
tmap=20cleared.=0D=0A>=20>=20This=20patch=20update=20the=20bitmap=20under=
=20the=20same=20nid_list_lock=20in=20add_free_nid.=0D=0A>=20>=0D=0A>=20>=20=
Signed-off-by:=20Fan=20li=20<fanofcode.li=40samsung.com>=0D=0A>=20>=20---=
=0D=0A>=20>=20=20fs/f2fs/node.c=20=7C=2082=0D=0A>=20>=20+++++++++++++++++++=
+++++++++++----------------------------=0D=0A>=20>=20=201=20file=20changed,=
=2042=20insertions(+),=2040=20deletions(-)=0D=0A>=20>=0D=0A>=20>=20diff=20-=
-git=20a/fs/f2fs/node.c=20b/fs/f2fs/node.c=20index=20b965a53..0a217d2=0D=0A=
>=20>=20100644=0D=0A>=20>=20---=20a/fs/f2fs/node.c=0D=0A>=20>=20+++=20b/fs/=
f2fs/node.c=0D=0A>=20>=20=40=40=20-1811,8=20+1811,33=20=40=40=20static=20vo=
id=20__move_free_nid(struct=20f2fs_sb_info=20*sbi,=20struct=20free_nid=20*i=
,=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=20=20=7D=0D=0A>=20>=0D=0A>=20>=20+stati=
c=20void=20update_free_nid_bitmap(struct=20f2fs_sb_info=20*sbi,=20nid_t=20n=
id,=0D=0A>=20>=20+=09=09=09=09=09=09=09bool=20set,=20bool=20build)=0D=0A>=
=20>=20+=7B=0D=0A>=20>=20+=09struct=20f2fs_nm_info=20*nm_i=20=3D=20NM_I(sbi=
);=0D=0A>=20>=20+=09unsigned=20int=20nat_ofs=20=3D=20NAT_BLOCK_OFFSET(nid);=
=0D=0A>=20>=20+=09unsigned=20int=20nid_ofs=20=3D=20nid=20-=20START_NID(nid)=
;=0D=0A>=20>=20+=0D=0A>=20>=20+=09if=20(=21test_bit_le(nat_ofs,=20nm_i->nat=
_block_bitmap))=0D=0A>=20>=20+=09=09return;=0D=0A>=20>=20+=0D=0A>=20>=20+=
=09if=20(set)=20=7B=0D=0A>=20>=20+=09=09if=20(test_bit_le(nid_ofs,=20nm_i->=
free_nid_bitmap=5Bnat_ofs=5D))=0D=0A>=20>=20+=09=09=09return;=0D=0A>=20>=20=
+=09=09__set_bit_le(nid_ofs,=20nm_i->free_nid_bitmap=5Bnat_ofs=5D);=0D=0A>=
=20>=20+=09=09nm_i->free_nid_count=5Bnat_ofs=5D++;=0D=0A>=20>=20+=09=7D=20e=
lse=20=7B=0D=0A>=20>=20+=09=09if=20(=21test_bit_le(nid_ofs,=20nm_i->free_ni=
d_bitmap=5Bnat_ofs=5D))=0D=0A>=20>=20+=09=09=09return;=0D=0A>=20>=20+=09=09=
__clear_bit_le(nid_ofs,=20nm_i->free_nid_bitmap=5Bnat_ofs=5D);=0D=0A>=20>=
=20+=09=09if=20(=21build)=0D=0A>=20>=20+=09=09=09nm_i->free_nid_count=5Bnat=
_ofs=5D--;=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20+=7D=0D=0A>=20>=20+=0D=0A>=20>=
=20=20/*=20return=20if=20the=20nid=20is=20recognized=20as=20free=20*/=20-st=
atic=20bool=0D=0A>=20>=20add_free_nid(struct=20f2fs_sb_info=20*sbi,=20nid_t=
=20nid,=20bool=20build)=0D=0A>=20>=20+static=20bool=20add_free_nid(struct=
=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20+=09=09=09=09nid_t=20nid,=20bool=20bui=
ld,=20bool=20update)=0D=0A>=20>=20=20=7B=0D=0A>=20>=20=20=09struct=20f2fs_n=
m_info=20*nm_i=20=3D=20NM_I(sbi);=0D=0A>=20>=20=20=09struct=20free_nid=20*i=
,=20*e;=0D=0A>=20>=20=40=40=20-1870,6=20+1895,11=20=40=40=20static=20bool=
=20add_free_nid(struct=20f2fs_sb_info=20*sbi,=20nid_t=20nid,=20bool=20build=
)=0D=0A>=20>=20=20=09ret=20=3D=20true;=0D=0A>=20>=20=20=09err=20=3D=20__ins=
ert_free_nid(sbi,=20i,=20FREE_NID);=0D=0A>=20>=20=20err_out:=0D=0A>=20>=20+=
=09if=20(update)=20=7B=0D=0A>=20>=20+=09=09update_free_nid_bitmap(sbi,=20ni=
d,=20ret,=20build);=0D=0A>=20>=20+=09=09if=20(=21build)=0D=0A>=20>=20+=09=
=09=09nm_i->available_nids++;=0D=0A>=20>=20+=09=7D=0D=0A>=20>=20=20=09spin_=
unlock(&nm_i->nid_list_lock);=0D=0A>=20>=20=20=09radix_tree_preload_end();=
=0D=0A>=20>=20=20err:=0D=0A>=20>=20=40=40=20-1896,30=20+1926,6=20=40=40=20s=
tatic=20void=20remove_free_nid(struct=20f2fs_sb_info=20*sbi,=20nid_t=20nid)=
=0D=0A>=20>=20=20=09=09kmem_cache_free(free_nid_slab,=20i);=0D=0A>=20>=20=
=20=7D=0D=0A>=20>=0D=0A>=20>=20-static=20void=20update_free_nid_bitmap(stru=
ct=20f2fs_sb_info=20*sbi,=20nid_t=20nid,=0D=0A>=20>=20-=09=09=09=09=09=09=
=09bool=20set,=20bool=20build)=0D=0A>=20>=20-=7B=0D=0A>=20>=20-=09struct=20=
f2fs_nm_info=20*nm_i=20=3D=20NM_I(sbi);=0D=0A>=20>=20-=09unsigned=20int=20n=
at_ofs=20=3D=20NAT_BLOCK_OFFSET(nid);=0D=0A>=20>=20-=09unsigned=20int=20nid=
_ofs=20=3D=20nid=20-=20START_NID(nid);=0D=0A>=20>=20-=0D=0A>=20>=20-=09if=
=20(=21test_bit_le(nat_ofs,=20nm_i->nat_block_bitmap))=0D=0A>=20>=20-=09=09=
return;=0D=0A>=20>=20-=0D=0A>=20>=20-=09if=20(set)=20=7B=0D=0A>=20>=20-=09=
=09if=20(test_bit_le(nid_ofs,=20nm_i->free_nid_bitmap=5Bnat_ofs=5D))=0D=0A>=
=20>=20-=09=09=09return;=0D=0A>=20>=20-=09=09__set_bit_le(nid_ofs,=20nm_i->=
free_nid_bitmap=5Bnat_ofs=5D);=0D=0A>=20>=20-=09=09nm_i->free_nid_count=5Bn=
at_ofs=5D++;=0D=0A>=20>=20-=09=7D=20else=20=7B=0D=0A>=20>=20-=09=09if=20(=
=21test_bit_le(nid_ofs,=20nm_i->free_nid_bitmap=5Bnat_ofs=5D))=0D=0A>=20>=
=20-=09=09=09return;=0D=0A>=20>=20-=09=09__clear_bit_le(nid_ofs,=20nm_i->fr=
ee_nid_bitmap=5Bnat_ofs=5D);=0D=0A>=20>=20-=09=09if=20(=21build)=0D=0A>=20>=
=20-=09=09=09nm_i->free_nid_count=5Bnat_ofs=5D--;=0D=0A>=20>=20-=09=7D=0D=
=0A>=20>=20-=7D=0D=0A>=20>=20-=0D=0A>=20>=20=20static=20void=20scan_nat_pag=
e(struct=20f2fs_sb_info=20*sbi,=0D=0A>=20>=20=20=09=09=09struct=20page=20*n=
at_page,=20nid_t=20start_nid)=20=20=7B=20=40=40=20-1937,18=20+1943,18=20=40=
=40=0D=0A>=20>=20static=20void=20scan_nat_page(struct=20f2fs_sb_info=20*sbi=
,=0D=0A>=20>=20=20=09i=20=3D=20start_nid=20%=20NAT_ENTRY_PER_BLOCK;=0D=0A>=
=20>=0D=0A>=20>=20=20=09for=20(;=20i=20<=20NAT_ENTRY_PER_BLOCK;=20i++,=20st=
art_nid++)=20=7B=0D=0A>=20>=20-=09=09bool=20freed=20=3D=20false;=0D=0A>=20>=
=20-=0D=0A>=20>=20=20=09=09if=20(unlikely(start_nid=20>=3D=20nm_i->max_nid)=
)=0D=0A>=20>=20=20=09=09=09break;=0D=0A>=20>=0D=0A>=20>=20=20=09=09blk_addr=
=20=3D=20le32_to_cpu(nat_blk->entries=5Bi=5D.block_addr);=0D=0A>=20>=20=20=
=09=09f2fs_bug_on(sbi,=20blk_addr=20=3D=3D=20NEW_ADDR);=0D=0A>=20>=20-=09=
=09if=20(blk_addr=20=3D=3D=20NULL_ADDR)=0D=0A>=20>=20-=09=09=09freed=20=3D=
=20add_free_nid(sbi,=20start_nid,=20true);=0D=0A>=20>=20-=09=09spin_lock(&N=
M_I(sbi)->nid_list_lock);=0D=0A>=20>=20-=09=09update_free_nid_bitmap(sbi,=
=20start_nid,=20freed,=20true);=0D=0A>=20>=20-=09=09spin_unlock(&NM_I(sbi)-=
>nid_list_lock);=0D=0A>=20>=20+=09=09if=20(blk_addr=20=3D=3D=20NULL_ADDR)=
=20=7B=0D=0A>=20>=20+=09=09=09add_free_nid(sbi,=20start_nid,=20true,=20true=
);=0D=0A>=20>=20+=09=09=7D=20else=20=7B=0D=0A>=20>=20+=09=09=09spin_lock(&N=
M_I(sbi)->nid_list_lock);=0D=0A>=20>=20+=09=09=09update_free_nid_bitmap(sbi=
,=20start_nid,=20false,=20true);=0D=0A>=20>=20+=09=09=09spin_unlock(&NM_I(s=
bi)->nid_list_lock);=0D=0A>=20>=20+=09=09=7D=0D=0A>=20>=20=20=09=7D=0D=0A>=
=20>=20=20=7D=0D=0A>=20>=0D=0A>=20>=20=40=40=20-1974,7=20+1980,7=20=40=40=
=20static=20void=20scan_free_nid_bits(struct=20f2fs_sb_info=20*sbi)=0D=0A>=
=20>=20=20=09=09=09=09break;=0D=0A>=20>=0D=0A>=20>=20=20=09=09=09nid=20=3D=
=20i=20*=20NAT_ENTRY_PER_BLOCK=20+=20idx;=0D=0A>=20>=20-=09=09=09add_free_n=
id(sbi,=20nid,=20true);=0D=0A>=20>=20+=09=09=09add_free_nid(sbi,=20nid,=20t=
rue,=20false);=0D=0A>=20>=0D=0A>=20>=20=20=09=09=09if=20(nm_i->nid_cnt=5BFR=
EE_NID=5D=20>=3D=20MAX_FREE_NIDS)=0D=0A>=20>=20=20=09=09=09=09goto=20out;=
=0D=0A>=20>=20=40=40=20-1988,7=20+1994,7=20=40=40=20static=20void=20scan_fr=
ee_nid_bits(struct=20f2fs_sb_info=20*sbi)=0D=0A>=20>=20=20=09=09addr=20=3D=
=20le32_to_cpu(nat_in_journal(journal,=20i).block_addr);=0D=0A>=20>=20=20=
=09=09nid=20=3D=20le32_to_cpu(nid_in_journal(journal,=20i));=0D=0A>=20>=20=
=20=09=09if=20(addr=20=3D=3D=20NULL_ADDR)=0D=0A>=20>=20-=09=09=09add_free_n=
id(sbi,=20nid,=20true);=0D=0A>=20>=20+=09=09=09add_free_nid(sbi,=20nid,=20t=
rue,=20false);=0D=0A>=20>=20=20=09=09else=0D=0A>=20>=20=20=09=09=09remove_f=
ree_nid(sbi,=20nid);=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=20=40=40=20-2053,7=
=20+2059,7=20=40=40=20static=20void=20__build_free_nids(struct=20f2fs_sb_in=
fo=20*sbi,=20bool=20sync,=20bool=20mount)=0D=0A>=20>=20=20=09=09addr=20=3D=
=20le32_to_cpu(nat_in_journal(journal,=20i).block_addr);=0D=0A>=20>=20=20=
=09=09nid=20=3D=20le32_to_cpu(nid_in_journal(journal,=20i));=0D=0A>=20>=20=
=20=09=09if=20(addr=20=3D=3D=20NULL_ADDR)=0D=0A>=20>=20-=09=09=09add_free_n=
id(sbi,=20nid,=20true);=0D=0A>=20>=20+=09=09=09add_free_nid(sbi,=20nid,=20t=
rue,=20false);=0D=0A>=20>=20=20=09=09else=0D=0A>=20>=20=20=09=09=09remove_f=
ree_nid(sbi,=20nid);=0D=0A>=20>=20=20=09=7D=0D=0A>=20>=20=40=40=20-2499,11=
=20+2505,7=20=40=40=20static=20void=20__flush_nat_entry_set(struct=20f2fs_s=
b_info=20*sbi,=0D=0A>=20>=20=20=09=09nat_reset_flag(ne);=0D=0A>=20>=20=20=
=09=09__clear_nat_cache_dirty(NM_I(sbi),=20set,=20ne);=0D=0A>=20>=20=20=09=
=09if=20(nat_get_blkaddr(ne)=20=3D=3D=20NULL_ADDR)=20=7B=0D=0A>=20>=20-=09=
=09=09add_free_nid(sbi,=20nid,=20false);=0D=0A>=20>=20-=09=09=09spin_lock(&=
NM_I(sbi)->nid_list_lock);=0D=0A>=20>=20-=09=09=09NM_I(sbi)->available_nids=
++;=0D=0A>=20>=20-=09=09=09update_free_nid_bitmap(sbi,=20nid,=20true,=20fal=
se);=0D=0A>=20>=20-=09=09=09spin_unlock(&NM_I(sbi)->nid_list_lock);=0D=0A>=
=20>=20+=09=09=09add_free_nid(sbi,=20nid,=20false,=20true);=0D=0A>=20>=20=
=20=09=09=7D=20else=20=7B=0D=0A>=20>=20=20=09=09=09spin_lock(&NM_I(sbi)->ni=
d_list_lock);=0D=0A>=20>=20=20=09=09=09update_free_nid_bitmap(sbi,=20nid,=
=20false,=20false);=0D=0A>=20>=0D=0A>=20=0D=0A=0D=0A=0D=0A
