From: =?UTF-8?B?0JjQstCw0L0g0KHQvtC70Y/QvdC60LjQvQ==?= <vanzef@gmail.com>
Subject: Re: crash of f2fs partition
Date: Thu, 8 May 2014 18:29:48 +0400
Message-ID: <CAHn27kYrqF9KM2W+hwx0Zt0Tkbd8y-RhdnZX5M+kbwzVaa50FQ@mail.gmail.com>
References: <CAHn27kbqKEZ5roxhygGNYTz7LddNV0562qDu=JFWw=39OKU+6A@mail.gmail.com>
	<1399538396.13268.40.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6726191351401139427=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vanzef@gmail.com>) id 1WiPKd-0000qt-W0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 May 2014 14:29:56 +0000
Received: from mail-qg0-f50.google.com ([209.85.192.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WiPKc-0006z9-IH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 May 2014 14:29:55 +0000
Received: by mail-qg0-f50.google.com with SMTP id z60so2791213qgd.37
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 08 May 2014 07:29:49 -0700 (PDT)
In-Reply-To: <1399538396.13268.40.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

--===============6726191351401139427==
Content-Type: multipart/alternative; boundary=001a113a4ae2380c8004f8e450ef

--001a113a4ae2380c8004f8e450ef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!
Thank you for reply.
I didn't remember my kernel version, but update to 3.14.2 didn't help me.


2014-05-08 12:39 GMT+04:00 Jaegeuk Kim <jaegeuk.kim@samsung.com>:

> Hi,
>
> 2014-05-07 (=EC=88=98), 21:54 +0400, =D0=98=D0=B2=D0=B0=D0=BD =D0=A1=D0=
=BE=D0=BB=D1=8F=D0=BD=D0=BA=D0=B8=D0=BD:
> > Hello, everybody!
> >
> >
> > I use F2FS as my /home fs (it is on usb flash drive). One day I was
> > using Skype and it freezed my laptop, so i needed to reboot. After
> > reboot I had next error message: "Failed to mount /home". I use
> > Archlinux. It is not kernel problem, because live cd also couldn't
> > mount it.
> >
> >
> > Here is my fsck.f2fs output:
> > Info: sector size =3D 512
> > Info: total sectors =3D 18857984 (in 512bytes)
> > [print_node_info:  77] Node ID [0x137d3:79827] is inode
> > i_mode                                [0x    81a4 : 33188]
> > i_uid                                 [0x     3e8 : 1000]
> > i_gid                                 [0x      64 : 100]
> > i_links                               [0x       1 : 1]
> > i_size                                [0x   300b0 : 196784]
> > i_blocks                              [0x      aa : 170]
> > i_atime                               [0x535d4015 : 1398620181]
> > i_atime_nsec                          [0x28c0e49b : 683730075]
> > i_ctime                               [0x535d4016 : 1398620182]
> > i_ctime_nsec                          [0x22cb0394 : 583730068]
> > i_mtime                               [0x535d4016 : 1398620182]
> > i_mtime_nsec                          [0x22cb0394 : 583730068]
> > i_generation                          [0x4f99325f : 1335439967]
> > i_current_depth                       [0x       1 : 1]
> > i_xattr_nid                           [0x       0 : 0]
> > i_flags                               [0x       0 : 0]
> > i_pino                                [0x     856 : 2134]
> > i_namelen                             [0x      11 : 17]
> > i_name                                [places.sqlite-wal]
> > i_ext: fofs:18 blkaddr:1984b4 len:0
> > i_addr[0]                             [0x  1ca848 : 1878088]
> > i_addr[1]                             [0x  1ca499 : 1877145]
> > i_addr[2]                             [0x  1ca49a : 1877146]
> > i_addr[3]                             [0x  1ca49b : 1877147]
> > i_addr[0x4] points data block   [0x1ca49c]
> > i_nid[0]                              [0x       0 : 0]
> > i_nid[1]                              [0x       0 : 0]
> > i_nid[2]                              [0x       0 : 0]
> > i_nid[3]                              [0x       0 : 0]
> > i_nid[4]                              [0x       0 : 0]
> >
> >
> > Assertion failed!
> > [fsck_chk_inode_blk: 394] i_blocks =3D=3D *blk_cnt
> >
> >
> > Here is a error message after mount:
> > http://imgur.com/alkvI3J
> >
> >
> > Is there any way to repair fs and if not - how can I take some files
> > from it?
>
> Thank you for the report.
>
> Could you share the kernel version that you're using?
>
> Currently, fsck.f2fs cannot fix any inconsistency, but it resides on my
> pending list.
>
> Anyway, you can get the files through the following mount option.
> -o disable_roll_forward
>
> Thanks,
> >
> > Thanks.
> >
> >
> >
> >
> -------------------------------------------------------------------------=
-----
> > Is your legacy SCM system holding you back? Join Perforce May 7 to find
> out:
> > &#149; 3 signs your SCM is hindering your productivity
> > &#149; Requirements for releasing software faster
> > &#149; Expert tips and advice for migrating your SCM now
> > http://p.sf.net/sfu/perforce
> > _______________________________________________ Linux-f2fs-devel mailin=
g
> list Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
> --
> Jaegeuk Kim
> Samsung
>
>


--=20
=D0=98=D0=B2=D0=B0=D0=BD

--001a113a4ae2380c8004f8e450ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi!<br></div>Thank you for reply.<br></div>I did=
n&#39;t remember my kernel version, but update to 3.14.2 didn&#39;t help me=
.<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">20=
14-05-08 12:39 GMT+04:00 Jaegeuk Kim <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:jaegeuk.kim@samsung.com" target=3D"_blank">jaegeuk.kim@samsung.com</a>&gt=
;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
2014-05-07 (=EC=88=98), 21:54 +0400, =D0=98=D0=B2=D0=B0=D0=BD =D0=A1=D0=BE=
=D0=BB=D1=8F=D0=BD=D0=BA=D0=B8=D0=BD:<br>
<div><div class=3D"h5">&gt; Hello, everybody!<br>
&gt;<br>
&gt;<br>
&gt; I use F2FS as my /home fs (it is on usb flash drive). One day I was<br=
>
&gt; using Skype and it freezed my laptop, so i needed to reboot. After<br>
&gt; reboot I had next error message: &quot;Failed to mount /home&quot;. I =
use<br>
&gt; Archlinux. It is not kernel problem, because live cd also couldn&#39;t=
<br>
&gt; mount it.<br>
&gt;<br>
&gt;<br>
&gt; Here is my fsck.f2fs output:<br>
&gt; Info: sector size =3D 512<br>
&gt; Info: total sectors =3D 18857984 (in 512bytes)<br>
&gt; [print_node_info: =C2=A077] Node ID [0x137d3:79827] is inode<br>
&gt; i_mode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A081a4 : 331=
88]<br>
&gt; i_uid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 3e8 : 10=
00]<br>
&gt; i_gid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A064=
 : 100]<br>
&gt; i_links =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 1 : 1]<=
br>
&gt; i_size =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 300b0 : 196784]<=
br>
&gt; i_blocks =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 =C2=A0aa : 1=
70]<br>
&gt; i_atime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x535d4015 : 1398620181]<br>
&gt; i_atime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x28c0e49b : 683730075]<br>
&gt; i_ctime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x535d4016 : 1398620182]<br>
&gt; i_ctime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x22cb0394 : 583730068]<br>
&gt; i_mtime =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x535d4016 : 1398620182]<br>
&gt; i_mtime_nsec =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x22cb0394 : 583730068]<br>
&gt; i_generation =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x4f99325f : 1335439967]<br>
&gt; i_current_depth =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 1 : 1]<br>
&gt; i_xattr_nid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<br>
&gt; i_flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A0 0 : 0]<=
br>
&gt; i_pino =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[0x =C2=A0 =C2=A0 856 : 213=
4]<br>
&gt; i_namelen =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A0 =C2=A0 =C2=A011 : 17]<br>
&gt; i_name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[places.sqlite-wal]<br>
&gt; i_ext: fofs:18 blkaddr:1984b4 len:0<br>
&gt; i_addr[0] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A01ca848 : 1878088]<br>
&gt; i_addr[1] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A01ca499 : 1877145]<br>
&gt; i_addr[2] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A01ca49a : 1877146]<br>
&gt; i_addr[3] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0x =C2=A01ca49b : 1877147]<br>
&gt; i_addr[0x4] points data block =C2=A0 [0x1ca49c]<br>
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
&gt; Assertion failed!<br>
&gt; [fsck_chk_inode_blk: 394] i_blocks =3D=3D *blk_cnt<br>
&gt;<br>
&gt;<br>
&gt; Here is a error message after mount:<br>
&gt; <a href=3D"http://imgur.com/alkvI3J" target=3D"_blank">http://imgur.co=
m/alkvI3J</a><br>
&gt;<br>
&gt;<br>
&gt; Is there any way to repair fs and if not - how can I take some files<b=
r>
&gt; from it?<br>
<br>
</div></div>Thank you for the report.<br>
<br>
Could you share the kernel version that you&#39;re using?<br>
<br>
Currently, fsck.f2fs cannot fix any inconsistency, but it resides on my<br>
pending list.<br>
<br>
Anyway, you can get the files through the following mount option.<br>
-o disable_roll_forward<br>
<br>
Thanks,<br>
&gt;<br>
&gt; Thanks.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Is your legacy SCM system holding you back? Join Perforce May 7 to fin=
d out:<br>
&gt; &amp;#149; 3 signs your SCM is hindering your productivity<br>
&gt; &amp;#149; Requirements for releasing software faster<br>
&gt; &amp;#149; Expert tips and advice for migrating your SCM now<br>
&gt; <a href=3D"http://p.sf.net/sfu/perforce" target=3D"_blank">http://p.sf=
.net/sfu/perforce</a><br>
&gt; _______________________________________________ Linux-f2fs-devel maili=
ng list <a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2f=
s-devel@lists.sourceforge.net</a> <a href=3D"https://lists.sourceforge.net/=
lists/listinfo/linux-f2fs-devel" target=3D"_blank">https://lists.sourceforg=
e.net/lists/listinfo/linux-f2fs-devel</a><br>

<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Jaegeuk Kim<br>
Samsung<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>=D0=98=D0=
=B2=D0=B0=D0=BD<br>
</div>

--001a113a4ae2380c8004f8e450ef--


--===============6726191351401139427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--===============6726191351401139427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6726191351401139427==--
