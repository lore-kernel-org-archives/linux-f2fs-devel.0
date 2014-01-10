From: folkert <folkert@vanheusden.com>
Subject: Re: assertion failed
Date: Fri, 10 Jan 2014 15:25:10 +0100
Message-ID: <20140110142510.GG8833@belle.intranet.vanheusden.com>
References: <20140102145632.GI8406@belle.intranet.vanheusden.com>
	<1389056518.3035.2.camel@kjgkr>
	<20140108210952.GB6833@belle.intranet.vanheusden.com>
	<1389338340.29315.3.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <folkert@vanheusden.com>) id 1W1d1U-0001cf-Pk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 14:25:20 +0000
Received: from keetweej.vanheusden.com ([80.101.105.103])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W1d1Q-00061j-VU
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Jan 2014 14:25:20 +0000
Content-Disposition: inline
In-Reply-To: <1389338340.29315.3.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

I'll give it a new try (e.g. purged git directory and re-cloned the git
repo).

I noticed while compiling this warning:

libf2fs.c: In function '__ffs':
libf2fs.c:157:3: warning: right shift count >=3D width of type [enabled by =
default]

This means that the result is always 0.

and also

fsck.c: In function fsck_chk_inode_blk=BF:
fsck.c:395:3: warning: format %d expects argument of type =BFint=BF, but ar=
gument 6 has type u64 [-Wformat]

This wreaks havoc when emitting multiple arguments due to more bytes on
the stack than what is expected.

The result output is:

[FSCK] Unreachable nat entries                        [Fail] [0x238c]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x1]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0xe8746]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Fail] [0xeaad2]
[FSCK] valid_inode_count matched with CP              [Ok..] [0xe3859]

Does that mean the fsck failed?


On Fri, Jan 10, 2014 at 04:19:00PM +0900, Jaegeuk Kim wrote:
> Hi,
> =

> Did you get the latest from:
> http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git?
> =

> Since this log shows the line number differently from the latest source
> codes.
> =

> For example,
> =

> [fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) =3D=
=3D
> hash_code
> =

> should be:
> =

> [fsck_chk_dentry_blk: 568] le32_to_cpu(de_blk->dentry[i].hash_code) =3D=
=3D
> hash_code
> =

> Thanks,
> =

> 2014-01-08 (???), 22:09 +0100, folkert:
> > Hi,
> >
> > After I installed the latest I got this error:
> >
> > build_nat_area_bitmap:1031] valid nat entries (block_addr !=3D 0x0) [0x=
 e65ee : 943598]
> > [build_sit_area_bitmap: 937] Blocks [0x198d273] Free Segs [0x1db2]
> > [fsck_chk_dentry_blk: 528] [  1] - no[0x2] name[belle] len[0x5] ino[0xd=
1] type[0x2]
> > [fsck_chk_dentry_blk: 528] [  2] - no[0x2] name[home] len[0x4] ino[0xd2=
] type[0x2]
> > [fsck_chk_dentry_blk: 528] [  3] - no[0x2] name[sandra] len[0x6] ino[0x=
d3] type[0x2]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x2] name[.less] len[0x5] ino[0xd=
4] type[0x1]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x3] name[.forward] len[0x8] ino[=
0xd5] type[0x1]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x4] name[.lessrc] len[0x7] ino[0=
xd6] type[0x1]
> > [fsck_chk_dentry_blk: 547] [  4] Dentry Block [0x1a3980a] Done : dentri=
es:3 in 214 slots (len:255)
> >
> > [fsck_chk_inode_blk: 377] Directory Inode: ino: d3 name: sandra depth: =
1 child files: 3
> >
> > [fsck_chk_dentry_blk: 528] [  3] - no[0x3] name[dialin] len[0x6] ino[0x=
d7] type[0x2]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x2] name[.less] len[0x5] ino[0xd=
8] type[0x1]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x3] name[.lessrc] len[0x7] ino[0=
xd9] type[0x1]
> > [fsck_chk_dentry_blk: 528] [  4] - no[0x4] name[.bash_history] len[0xd]=
 ino[0xda] type[0x1]
> >
> > Assertion failed!
> > [fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code) =3D=
=3D hash_code
> >
> >
> > On Tue, Jan 07, 2014 at 10:01:58AM +0900, Jaegeuk Kim wrote:
> > > Hi,
> > >
> > > Thank you for the report.
> > > Could you pull the lastest f2fs-tools and then test this again?
> > > Thanks,
> > >
> > > 2014-01-02 (???), 15:56 +0100, folkert:
> > > > Hi,
> > > >
> > > > While running fsck.f2fs I get an assertion. This is with the f2fs f=
rom
> > > > git from half an hour ago:
> > > >
> > > > +--------------------------------------------------------+
> > > > | Checkpoint                                             |
> > > > +--------------------------------------------------------+
> > > > checkpoint_ver                          [0x     4a7 : 1191]
> > > > user_block_count                        [0x 1bcce00 : 29150720]
> > > > valid_block_count                       [0x 19769e2 : 26700258]
> > > > rsvd_segment_count                      [0x      30 : 48]
> > > > overprov_segment_count                  [0x     be4 : 3044]
> > > > free_segment_count                      [0x    1e7f : 7807]
> > > > alloc_type[CURSEG_HOT_NODE]             [0x       0 : 0]
> > > > alloc_type[CURSEG_WARM_NODE]            [0x       0 : 0]
> > > > alloc_type[CURSEG_COLD_NODE]            [0x       0 : 0]
> > > > cur_node_segno[0]                       [0x    df99 : 57241]
> > > > cur_node_segno[1]                       [0x    df91 : 57233]
> > > > cur_node_segno[2]                       [0x    d565 : 54629]
> > > > cur_node_blkoff[0]                      [0x     1a4 : 420]
> > > > cur_node_blkoff[1]                      [0x     1a5 : 421]
> > > > cur_node_blkoff[2]                      [0x       7 : 7]
> > > > alloc_type[CURSEG_HOT_DATA]             [0x       0 : 0]
> > > > alloc_type[CURSEG_WARM_DATA]            [0x       0 : 0]
> > > > alloc_type[CURSEG_COLD_DATA]            [0x       0 : 0]
> > > > cur_data_segno[0]                       [0x    dfef : 57327]
> > > > cur_data_segno[1]                       [0x    a531 : 42289]
> > > > cur_data_segno[2]                       [0x    a70d : 42765]
> > > > cur_data_blkoff[0]                      [0x      63 : 99]
> > > > cur_data_blkoff[1]                      [0x     13a : 314]
> > > > cur_data_blkoff[2]                      [0x      c3 : 195]
> > > > ckpt_flags                              [0x       5 : 5]
> > > > cp_pack_total_block_count               [0x       7 : 7]
> > > > cp_pack_start_sum                       [0x       1 : 1]
> > > > valid_node_count                        [0x   e359f : 931231]
> > > > valid_inode_count                       [0x   de77c : 911228]
> > > > next_free_nid                           [0x  11f16c : 1175916]
> > > > sit_ver_bitmap_bytesize                 [0x      c0 : 192]
> > > > nat_ver_bitmap_bytesize                 [0x     e80 : 3712]
> > > > checksum_offset                         [0x     ffc : 4092]
> > > > elapsed_time                            [0x  7f5b6a : 8346474]
> > > > sit_nat_version_bitmap[0]               [0x      40 : 64]
> > > >
> > > >
> > > > [build_nat_area_bitmap:1031] valid nat entries (block_addr !=3D 0x0=
) [0x
> > > > e520f : 938511]
> > > > [build_sit_area_bitmap: 937] Blocks [0x19769e2] Free Segs [0x1e7f]
> > > > [fsck_chk_dentry_blk: 547] [  4] Dentry Block [0x1a3980a] Done :
> > > > dentries:3 in 214 slots (len:255)
> > > >
> > > > [fsck_chk_inode_blk: 377] Directory Inode: ino: d3 name: sandra dep=
th: 1
> > > > child files: 3
> > > >
> > > >
> > > > Assertion failed!
> > > > [fsck_chk_dentry_blk: 509] le32_to_cpu(de_blk->dentry[i].hash_code)=
 =3D=3D
> > > > hash_code
> > > >
> > > >
> > > >
> > > > Folkert van Heusden
> > > >
> > >
> > > --
> > > Jaegeuk Kim
> > > Samsung
> >
> >
> > Folkert van Heusden
> >
> =

> --
> Jaegeuk Kim
> Samsung


Folkert van Heusden

-- =

MultiTail =E4r ett flexibel redskap f=F6r att f=F6lja en eller flera logfil=
er, utf=F6ra
kommandon, filtrera, f=E4rgl=E4gga, sammanfoga, o.s.v...
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

---------------------------------------------------------------------------=
---
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. =

http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&iu=3D/4140/ostg.c=
lktrk
