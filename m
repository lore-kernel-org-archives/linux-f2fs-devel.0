From: Changman Lee <cm224.lee@gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: reorganize the f2fs_setattr()
	function.
Date: Mon, 24 Jun 2013 11:32:54 +0900
Message-ID: <CAN863PtNYrHx4wVwb7TzNz=QFkv6HDjE8+iigopb9m=8_MbM3Q@mail.gmail.com>
References: <1370694303-2738-1-git-send-email-linkinjeon@gmail.com>
	<1370824712.22405.18.camel@lcm>
	<CAKYAXd-V9iF0o5nvFyFPgJX0waDLh4c_eNJ7V_o-tbbrtX1JLQ@mail.gmail.com>
	<1370929716.14857.8.camel@lcm>
	<CAKYAXd98cgBU_JzL3zx2qT87H-XdqntdKYbCdOsx9gCeDwUO4Q@mail.gmail.com>
	<CAKYAXd_44td8BDbnuGR-ChHXjmhTnoVNq4vgujgAyAtbO6vayw@mail.gmail.com>
	<1371789772.14296.9.camel@lcm>
	<CAKYAXd8RQvY+-xRam2yymERAAf8oUEJ0Rznaev_ixy+xR=Ecrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6764129265642927232=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@gmail.com>) id 1UqwaV-0007FO-4p
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Jun 2013 02:33:03 +0000
Received: from mail-la0-f52.google.com ([209.85.215.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UqwaT-0005o4-MV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Jun 2013 02:33:03 +0000
Received: by mail-la0-f52.google.com with SMTP id fo12so9658859lab.11
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 23 Jun 2013 19:32:54 -0700 (PDT)
In-Reply-To: <CAKYAXd8RQvY+-xRam2yymERAAf8oUEJ0Rznaev_ixy+xR=Ecrg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

--===============6764129265642927232==
Content-Type: multipart/alternative; boundary=089e012296f2d812c404dfdd3abb

--089e012296f2d812c404dfdd3abb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2013. 6. 21. =EC=98=A4=ED=9B=84 4:30=EC=97=90 "Namjae Jeon" <linkinjeon@gma=
il.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> >
> > Sorry for late. I was very busy.
> >
> > Could you tell me if it happens difference between xattr and i_mode,
> > what will you do?
> First of all, I want to know which case make mismatching permission
> between xattr and i_mode.
> And when we call chmod, inode is locked in sys_chmod. If so,
> inode->i_mode can be changed by any updated inode during chmod
> although inode is locked ?
>

update_inode updates raw inode on disk from inode->i_mode.
As you know, dirtied inode page will written back to disk at unexpected
time according to dirty ratio or expired time. If you instantly modify
inode->i_mode, inode could be earlier written back than xattr. So I think
it is possible that inode->i_mode and xattr might be different when SPO is
occured and so on.

> > The purpose of i_acl_mode is used to update i_mode and xattr together i=
n
> > same lock region.
> Could you please tell me what is same lock region ? (inode->i_mutex or
> mutex_lock_op(sbi))
>
> Thanks.

I meant later.

> >
> >>
> >> >
> >> >
---------------------------------------------------------------------------=
-------------------------------------
> >> > Subject: [PATCH v2] f2fs: reorganize the f2fs_setattr(),
f2fs_set_acl,
> >> > f2fs_setxattr()
> >> > From: Namjae Jeon <namjae.jeon@samsung.com>
> >> >
>
>
---------------------------------------------------------------------------=
---
> This SF.net email is sponsored by Windows:
>
> Build for Windows Store.
>
> http://p.sf.net/sfu/windows-dev2dev
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--089e012296f2d812c404dfdd3abb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
2013. 6. 21. =EC=98=A4=ED=9B=84 4:30=EC=97=90 &quot;Namjae Jeon&quot; &lt;<=
a href=3D"mailto:linkinjeon@gmail.com">linkinjeon@gmail.com</a>&gt;=EB=8B=
=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Sorry for late. I was very busy.<br>
&gt; &gt;<br>
&gt; &gt; Could you tell me if it happens difference between xattr and i_mo=
de,<br>
&gt; &gt; what will you do?<br>
&gt; First of all, I want to know which case make mismatching permission<br=
>
&gt; between xattr and i_mode.<br>
&gt; And when we call chmod, inode is locked in sys_chmod. If so,<br>
&gt; inode-&gt;i_mode can be changed by any updated inode during chmod<br>
&gt; although inode is locked ?<br>
&gt;</p>
<p dir=3D"ltr">update_inode updates raw inode on disk from inode-&gt;i_mode=
.<br>
As you know, dirtied inode page will written back to disk at unexpected tim=
e according to dirty ratio or expired time. If you instantly modify inode-&=
gt;i_mode, inode could be earlier written back than xattr. So I think it is=
 possible that inode-&gt;i_mode and xattr might be different when SPO is oc=
cured and so on.</p>

<p dir=3D"ltr">&gt; &gt; The purpose of i_acl_mode is used to update i_mode=
 and xattr together in<br>
&gt; &gt; same lock region.<br>
&gt; Could you please tell me what is same lock region ? (inode-&gt;i_mutex=
 or<br>
&gt; mutex_lock_op(sbi))<br>
&gt;<br>
&gt; Thanks.</p>
<p dir=3D"ltr">I meant later.</p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; --------------------------------------------------------=
--------------------------------------------------------<br>
&gt; &gt;&gt; &gt; Subject: [PATCH v2] f2fs: reorganize the f2fs_setattr(),=
 f2fs_set_acl,<br>
&gt; &gt;&gt; &gt; f2fs_setxattr()<br>
&gt; &gt;&gt; &gt; From: Namjae Jeon &lt;<a href=3D"mailto:namjae.jeon@sams=
ung.com">namjae.jeon@samsung.com</a>&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; This SF.net email is sponsored by Windows:<br>
&gt;<br>
&gt; Build for Windows Store.<br>
&gt;<br>
&gt; <a href=3D"http://p.sf.net/sfu/windows-dev2dev">http://p.sf.net/sfu/wi=
ndows-dev2dev</a><br>
&gt; _______________________________________________<br>
&gt; Linux-f2fs-devel mailing list<br>
&gt; <a href=3D"mailto:Linux-f2fs-devel@lists.sourceforge.net">Linux-f2fs-d=
evel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/linux-f2fs-dev=
el">https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel</a><br>
</p>

--089e012296f2d812c404dfdd3abb--


--===============6764129265642927232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============6764129265642927232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============6764129265642927232==--
