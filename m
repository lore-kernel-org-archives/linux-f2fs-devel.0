From: Matt Parnell <mparnell@gmail.com>
Subject: Re: Power Outage Corruption - Recovery?
Date: Sun, 10 Aug 2014 08:37:21 +0000
Message-ID: <CABeR2605VuEhHn18Tnu7TU6M1ib0r0ooTB4BW3PyZmOnyOTtZQ@mail.gmail.com>
References: <CABeR261Ep6fw+--kdtUCTEK0zktnRYQ=y6ScCKa8YEMXMxadOg@mail.gmail.com>
	<20140810071629.GA1484@jaegeuk-mac02.mot-mobility.com>
	<CABeR261hCTkypy7-9OJN0sXZ-TZ_HfSk0Ny0jxGCTujcg20nYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6539149511202176756=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mparnell@gmail.com>) id 1XGOd6-0003Cc-2l
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 08:37:28 +0000
Received: from mail-qg0-f50.google.com ([209.85.192.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XGOd4-0006qb-Kq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Aug 2014 08:37:28 +0000
Received: by mail-qg0-f50.google.com with SMTP id q108so7488645qgd.37
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 10 Aug 2014 01:37:21 -0700 (PDT)
In-Reply-To: <CABeR261hCTkypy7-9OJN0sXZ-TZ_HfSk0Ny0jxGCTujcg20nYg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

--===============6539149511202176756==
Content-Type: multipart/alternative; boundary=001a11c308eccbe9c9050042586a

--001a11c308eccbe9c9050042586a
Content-Type: text/plain; charset=UTF-8

Luks that is. Autocorrect error.
On Aug 10, 2014 3:36 AM, "Matt Parnell" <mparnell@gmail.com> wrote:

> Disabling roll forward allowed for the mount, excellent! I really should
> have tried that option before bothering you, though it may have prevented
> disclosure of the bug.
>
> I still believe that adding the recovery option for dump could be a good
> thing to do. Seeing as how this is working out, I'll copy the files,
> reformat, and carry on with f2fs. It runs quite well on both my phone and
> my intel ssd on top of Lukas with discards enabled.
> On Aug 10, 2014 2:17 AM, "Jaegeuk Kim" <jaegeuk@kernel.org> wrote:
>
>> Hi Matt,
>>
>> On Sat, Aug 09, 2014 at 10:15:15PM +0000, Matt Parnell wrote:
>> > I had a similar issue as a gentlemen whose message I recently read on
>> this
>> > list, where power loss caused his f2fs partition to cause a kernel oops
>> > every time it was attempted to mount. I have the same issue. Is any
>> form of
>> > recovery possible?
>>
>> Ok, it seems that there is a roll-forward bug.
>> Could you mount it with -o disable_roll_forward?
>>
>> >
>> > Photorec was able to get most of it but there are two hard drive keys
>> and a
>> > keepass database that I wish to try and recover.
>> >
>> > Setting fsck.f2fs debug level to 9, I can get output like the below and
>> > even view the inode information with dump.f2fs.
>>
>> I think I can add some codes in dump.f2fs to recover specific files with
>> inode numbers.
>> I'll look into this.
>>
>> Thanks,
>>
>> >
>> > Is there a way I can, through a program or through hex editing, get
>> these
>> > files back, or even repair the whole partition?
>> >
>> > Thanks!
>> >
>> > fsck output:
>> >
>> > [fsck_chk_dentry_blk: 567] [  2] - no[0x8d] name[keys] len[0x4]
>> ino[0x3a1]
>> > type[0x2]
>> > [fsck_chk_xattr_blk: 709] ino[0x3a1] x_nid[0x3a8]
>> > [fsck_chk_dentry_blk: 567] [  3] - no[0x2] name[storage.key] len[0xb]
>> > ino[0x3a2] type[0x1]
>> > [fsck_chk_xattr_blk: 709] ino[0x3a2] x_nid[0x3a3]
>> > [fsck_chk_dentry_blk: 567] [  3] - no[0x4] name[tmp.key] len[0x7]
>> > ino[0x3a4] type[0x1]
>> > [fsck_chk_xattr_blk: 709] ino[0x3a4] x_nid[0x3a5]
>> > [fsck_chk_dentry_blk: 567] [  3] - no[0x5] name[home.key] len[0x8]
>> > ino[0x3a6] type[0x1]
>> > [fsck_chk_xattr_blk: 709] ino[0x3a6] x_nid[0x3a7]
>> > [fsck_chk_dentry_blk: 588] [  3] Dentry Block [0xac3912] Done :
>> dentries:3
>> > in 214 slots (len:255)
>> >
>> > [fsck_chk_inode_blk: 379] Directory Inode: ino: 3a1 name: keys depth: 1
>> > child files: 3
>> >
>> > inode dump:
>> >
>> > Info: sector size = 512
>> > Info: total sectors = 92270592 (in 512bytes)
>> > [print_node_info:  77] Node ID [0x3a2:930] is inode
>> > i_mode                                [0x    81a4 : 33188]
>> > i_uid                                 [0x       0 : 0]
>> > i_gid                                 [0x       0 : 0]
>> > i_links                               [0x       1 : 1]
>> > i_size                                [0x    1000 : 4096]
>> > i_blocks                              [0x       3 : 3]
>> > i_atime                               [0x53b92ed2 : 1404645074]
>> > i_atime_nsec                          [0x234fa2de : 592421598]
>> > i_ctime                               [0x53ba3331 : 1404711729]
>> > i_ctime_nsec                          [0x3a88bfa8 : 982040488]
>> > i_mtime                               [0x53b90ec9 : 1404636873]
>> > i_mtime_nsec                          [0x374e1dc2 : 927866306]
>> > i_generation                          [0xf382a0df : 4085424351]
>> > i_current_depth                       [0x       1 : 1]
>> > i_xattr_nid                           [0x     3a3 : 931]
>> > i_flags                               [0x       0 : 0]
>> > i_pino                                [0x     3a1 : 929]
>> > i_namelen                             [0x       b : 11]
>> > i_name                                [storage.key]
>> > i_ext: fofs:0 blkaddr:693511 len:1
>> > i_addr[0]                             [0x  693511 : 6894865]
>> > i_addr[1]                             [0x       0 : 0]
>> > i_addr[2]                             [0x       0 : 0]
>> > i_addr[3]                             [0x       0 : 0]
>> > i_nid[0]                              [0x       0 : 0]
>> > i_nid[1]                              [0x       0 : 0]
>> > i_nid[2]                              [0x       0 : 0]
>> > i_nid[3]                              [0x       0 : 0]
>> > i_nid[4]                              [0x       0 : 0]
>> >
>> >
>> > Done.
>>
>> >
>> ------------------------------------------------------------------------------
>>
>> > _______________________________________________
>> > Linux-f2fs-devel mailing list
>> > Linux-f2fs-devel@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
>>

--001a11c308eccbe9c9050042586a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Luks that is. Autocorrect error.</p>
<div class=3D"gmail_quote">On Aug 10, 2014 3:36 AM, &quot;Matt Parnell&quot=
; &lt;<a href=3D"mailto:mparnell@gmail.com">mparnell@gmail.com</a>&gt; wrot=
e:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<p dir=3D"ltr">Disabling roll forward allowed for the mount, excellent! I r=
eally should have tried that option before bothering you, though it may hav=
e prevented disclosure of the bug.</p>
<p dir=3D"ltr">I still believe that adding the recovery option for dump cou=
ld be a good thing to do. Seeing as how this is working out, I&#39;ll copy =
the files, reformat, and carry on with f2fs. It runs quite well on both my =
phone and my intel ssd on top of Lukas with discards enabled.</p>


<div class=3D"gmail_quote">On Aug 10, 2014 2:17 AM, &quot;Jaegeuk Kim&quot;=
 &lt;<a href=3D"mailto:jaegeuk@kernel.org" target=3D"_blank">jaegeuk@kernel=
.org</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Hi Matt,<br>
<br>
On Sat, Aug 09, 2014 at 10:15:15PM +0000, Matt Parnell wrote:<br>
&gt; I had a similar issue as a gentlemen whose message I recently read on =
this<br>
&gt; list, where power loss caused his f2fs partition to cause a kernel oop=
s<br>
&gt; every time it was attempted to mount. I have the same issue. Is any fo=
rm of<br>
&gt; recovery possible?<br>
<br>
Ok, it seems that there is a roll-forward bug.<br>
Could you mount it with -o disable_roll_forward?<br>
<br>
&gt;<br>
&gt; Photorec was able to get most of it but there are two hard drive keys =
and a<br>
&gt; keepass database that I wish to try and recover.<br>
&gt;<br>
&gt; Setting fsck.f2fs debug level to 9, I can get output like the below an=
d<br>
&gt; even view the inode information with dump.f2fs.<br>
<br>
I think I can add some codes in dump.f2fs to recover specific files with<br=
>
inode numbers.<br>
I&#39;ll look into this.<br>
<br>
Thanks,<br>
<br>
&gt;<br>
&gt; Is there a way I can, through a program or through hex editing, get th=
ese<br>
&gt; files back, or even repair the whole partition?<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt; fsck output:<br>
&gt;<br>
&gt; [fsck_chk_dentry_blk: 567] [ =C2=A02] - no[0x8d] name[keys] len[0x4] i=
no[0x3a1]<br>
&gt; type[0x2]<br>
&gt; [fsck_chk_xattr_blk: 709] ino[0x3a1] x_nid[0x3a8]<br>
&gt; [fsck_chk_dentry_blk: 567] [ =C2=A03] - no[0x2] name[storage.key] len[=
0xb]<br>
&gt; ino[0x3a2] type[0x1]<br>
&gt; [fsck_chk_xattr_blk: 709] ino[0x3a2] x_nid[0x3a3]<br>
&gt; [fsck_chk_dentry_blk: 567] [ =C2=A03] - no[0x4] name[tmp.key] len[0x7]=
<br>
&gt; ino[0x3a4] type[0x1]<br>
&gt; [fsck_chk_xattr_blk: 709] ino[0x3a4] x_nid[0x3a5]<br>
&gt; [fsck_chk_dentry_blk: 567] [ =C2=A03] - no[0x5] name[home.key] len[0x8=
]<br>
&gt; ino[0x3a6] type[0x1]<br>
&gt; [fsck_chk_xattr_blk: 709] ino[0x3a6] x_nid[0x3a7]<br>
&gt; [fsck_chk_dentry_blk: 588] [ =C2=A03] Dentry Block [0xac3912] Done : d=
entries:3<br>
&gt; in 214 slots (len:255)<br>
&gt;<br>
&gt; [fsck_chk_inode_blk: 379] Directory Inode: ino: 3a1 name: keys depth: =
1<br>
&gt; child files: 3<br>
&gt;<br>
&gt; inode dump:<br>
&gt;<br>
&gt; Info: sector size =3D 512<br>
&gt; Info: total sectors =3D 92270592 (in 512bytes)<br>
&gt; [print_node_info: =C2=A077] Node ID [0x3a2:930] is inode<br>
&gt; i_mode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A081a4 : 331=
88]<br>
&gt; i_uid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0=
 : 0]<br>
&gt; i_gid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0=
 : 0]<br>
&gt; i_links =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 1 : 1]<=
br>
&gt; i_size =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A01000 : 409=
6]<br>
&gt; i_blocks =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 3 : 3=
]<br>
&gt; i_atime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x53b92ed2 : 1404645074]<br>
&gt; i_atime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x234fa2de : 592421598]<br>
&gt; i_ctime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x53ba3331 : 1404711729]<br>
&gt; i_ctime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x3a88bfa8 : 982040488]<br>
&gt; i_mtime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x53b90ec9 : 1404636873]<br>
&gt; i_mtime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x374e1dc2 : 927866306]<br>
&gt; i_generation =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0xf382a0df : <a href=3D"tel:4085424351" =
value=3D"+14085424351" target=3D"_blank">4085424351</a>]<br>
&gt; i_current_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 1 : 1]<br>
&gt; i_xattr_nid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 3a3 : 931]<br>
&gt; i_flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<=
br>
&gt; i_pino =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 3a1 : 929=
]<br>
&gt; i_namelen =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 b : 11]<br>
&gt; i_name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[storage.key]<br>
&gt; i_ext: fofs:0 blkaddr:693511 len:1<br>
&gt; i_addr[0] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0693511 : 6894865]<br>
&gt; i_addr[1] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<br>
&gt; i_addr[2] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<br>
&gt; i_addr[3] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<br>
&gt; i_nid[0] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 0 : 0=
]<br>
&gt; i_nid[1] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 0 : 0=
]<br>
&gt; i_nid[2] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 0 : 0=
]<br>
&gt; i_nid[3] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 0 : 0=
]<br>
&gt; i_nid[4] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0 0 : 0=
]<br>
&gt;<br>
&gt;<br>
&gt; Done.<br>
<br>
&gt; ----------------------------------------------------------------------=
--------<br>
<br>
&gt; _______________________________________________<br>
&gt; Linux-f2fs-devel mailing list<br>
&gt; <a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net" target=3D"_b=
lank">Linux-f2fs-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-dev=
el" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/linux-f2=
fs-devel</a><br>
<br>
</blockquote></div>
</blockquote></div>

--001a11c308eccbe9c9050042586a--


--===============6539149511202176756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6539149511202176756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6539149511202176756==--
