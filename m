From: Huajun Li <huajun.li.lee@gmail.com>
Subject: Re: [f2fs-dev] [RFC 0/5] Enable f2fs support inline data
Date: Sat, 8 Jun 2013 15:25:03 +0800
Message-ID: <CA+v9cxZVvW+puuSWOYPJ-QnMPq-=vSi3xbb79s1u8i43XN2Wxw@mail.gmail.com>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
	<1370312366.3600.3.camel@kjgkr>
	<CAKYAXd-87rGatnEC8wbocR_wt6Qdpec3HzZaH9ukpzmst6DK=A@mail.gmail.com>
	<20130604060119.GA3265@hli22-desktop>
	<1370416414.3600.36.camel@kjgkr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4208156267089258283=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li.lee@gmail.com>) id 1UlDWS-0008Ha-P4
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 07:25:12 +0000
Received: from mail-vc0-f171.google.com ([209.85.220.171])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UlDWP-0001No-C2
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 07:25:11 +0000
Received: by mail-vc0-f171.google.com with SMTP id gd11so463513vcb.30
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Jun 2013 00:25:03 -0700 (PDT)
In-Reply-To: <1370416414.3600.36.camel@kjgkr>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk.kim" <jaegeuk.kim@samsung.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, namjae.jeon@samsung.com, Huajun Li <huajun.li@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>

--===============4208156267089258283==
Content-Type: multipart/alternative; boundary=20cf307f32e82c164604de9f7238

--20cf307f32e82c164604de9f7238
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jaegeuk,
Thanks for your suggestion.

On Wed, Jun 5, 2013 at 3:13 PM, Jaegeuk Kim <jaegeuk.kim@samsung.com> wrote=
:

> Hi Haicheng,
>
> 2013-06-04 (=ED=99=94), 14:01 +0800, Haicheng Li:
> > Hi Jaegeuk & Namjae,
> >
> > Sure, we'll address your comments. And this version is RFC, just wanna =
to
> > make sure this feature is meaningful for f2fs project, and there is no
> obvious
> > mistake, e.g. missing some critical path.
>
> IMO, it is worth to design and implement the inline feature though, I'd
> like to review the total design before looking at trivial mistakes.
> Since if the initial design is changed frequently, we need to review
> again and again.
>
> Agree. So let's understand/clarify your following proposal firstly.

> So, we need to decide the overall inline design.
> Currently we have to consider three data structures at a same time for
> the on-disk *inline* inode block structure, which are data, dentry, and
> xattr as well.
>
> IMO, we can give three inode flags: F2FS_INLINE_DATA, F2FS_INLINE_DENT,
> and F2FS_INLINE_XATTR.
>
> Small data and dentries can be inline.  And xattr (such as XATTR_USER,
XATTR_TRUSTED, eg. ) can be inline too, right ?
Or inline xattr is just working for inline data/dentries?


> < on-disk inode block >
>  - metadata
>  - if F2FS_INLINE_XATTR is set,
>   : use fixed 2*255 bytes to *cache* two xattrs for simplicity
>

These 2 xattrs are working for the ones storing in xattr_nid block before,
or just providing info for inline data/dent ?

 `- if F2FS_INLINE_DATA is set,
>    : use the remained space varied by F2FS_INLINE_XATTR.
>  `- if F2FS_INLINE_DENT is set,
>    : use variable number of dentries determined by F2FS_INLINE_XATTR.
>
Do you mean inline dent depends on inline xattr, that is, we need a
dedicated xattr entry providing info for inline denteries, right?


>  `- Otherwise, use as pointers
>
> And then, we need to define how to deal with their combinations.
>
> Operational conditions
> ----------------------
>  - use inline xattr or not, by checking other inline flags and inline
> data size.
>  - calculate inline data size and its offset according to the use of
> inline xattrs.
>  - the places of inline operaions wrt the lock consistency and coverage
>  - Power-off-recovery routine should care about the on-disk inode
> structure.
>  - unset F2FS_INLINE_DATA if i_size =3D 0
>  - unset F2FS_INLINE_XATTR if xattr entries =3D 0
>  - unset F2FS_INLINE_DENT if dentries =3D 0
>
>  - what else?
>
- clear these flags after the inline data/dent is moved to normal data bloc=
k
- maybe we need store xattr_header while making xattr inline.


> Once we design the whole thing, we can make general functions to deal
> with them gracefully.
>
> > And if you team has some special opensource test suites used in your
> daily
> > f2fs test cycle, pls. kindly share the info with us, then we can make
> sure our
> > patchset can pass these cases before we send out next version.
>
> 1. xfstests for functionality
> 2. fsstress for deadlock/consistency check
> 3. power-off with fsstress
>
> Thanks,
>
> > BTW, test the kernel source tree or kernel build is a good suggestion.
> thanks.
> >
> > On Tue, Jun 04, 2013 at 01:23:57PM +0900, Namjae Jeon wrote:
> > > Hi. Huajun.
> > >
> > > I agree jaegeuk's opinion.
> > > Additionally, It is better that you describe the effect in change-log
> > > when this feature is added to f2fs.
> > > e.g.
> > >     1. how much space is saved when storing kernel-tree(small files) =
?
> > >     2. small files creation performance test.
> > >     3. file look-up performance test.
> > >     4. other performance tools 's result.
> > >
> > > Thanks.
> > >
> > > 2013/6/4 Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> > > > Hi,
> > > >
> > > > This feature is one of my todo items. ;)
> > > > Thank you for the contribution.
> > > >
> > > > Before reviewing the below code intensively, we need to check the
> > > > following issues.
> > > >
> > > > - deadlock conditions
> > > > - FS consistency
> > > > - recovery routine
> > > >
> > > > Could you check one more time?
> > > > Thanks again,
> > > >
> > > > 2013-06-03 (=EC=9B=94), 18:04 +0800, Huajun Li:
> > > >> f2fs inode is so large, small files can be stored directly in the
> inode,
> > > >> rather than just storing a single block address and storing the
> data elsewhere.
> > > >>
> > > >> This RFC patch set is just to enable f2fs support inline data:
> files less than
> > > >> about 3.6K can be stored directly in inode block.
> > > >>
> > > >> TODO: make small dirs inline too.
> > > >>
> > > >>
> > > >> Haicheng Li (3):
> > > >>   f2fs: Add helper functions and flag to support inline data
> > > >>   f2fs: Add interface for inline data support
> > > >>   f2fs: add tracepoints to debug inline data operations
> > > >>
> > > >> Huajun Li (2):
> > > >>   f2fs: Handle inline data read and write
> > > >>   f2fs: Key functions to handle inline data
> > > >>
> > > >>  fs/f2fs/Kconfig             |   10 +++
> > > >>  fs/f2fs/Makefile            |    1 +
> > > >>  fs/f2fs/data.c              |   78 +++++++++++++++++++++-
> > > >>  fs/f2fs/f2fs.h              |   70 +++++++++++++++++++
> > > >>  fs/f2fs/file.c              |    9 ++-
> > > >>  fs/f2fs/inline.c            |  156
> +++++++++++++++++++++++++++++++++++++++++++
> > > >>  fs/f2fs/inode.c             |    8 +++
> > > >>  include/linux/f2fs_fs.h     |    5 ++
> > > >>  include/trace/events/f2fs.h |   69 +++++++++++++++++++
> > > >>  9 files changed, 402 insertions(+), 4 deletions(-)
> > > >>  create mode 100644 fs/f2fs/inline.c
> > > >>
> > > >
> > > > --
> > > > Jaegeuk Kim
> > > > Samsung
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> linux-fsdevel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Jaegeuk Kim
> Samsung
>

--20cf307f32e82c164604de9f7238
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi Jaegeuk, </div><div clas=
s=3D"gmail_extra">Thanks for your suggestion.<br><br></div><div class=3D"gm=
ail_extra"><div class=3D"gmail_quote">On Wed, Jun 5, 2013 at 3:13 PM, Jaege=
uk Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:jaegeuk.kim@samsung.com" tar=
get=3D"_blank">jaegeuk.kim@samsung.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi Haicheng,<br>
<br>
2013-06-04 (=ED=99=94), 14:01 +0800, Haicheng Li:<br>
<div class=3D"im">&gt; Hi Jaegeuk &amp; Namjae,<br>
&gt;<br>
&gt; Sure, we&#39;ll address your comments. And this version is RFC, just w=
anna to<br>
&gt; make sure this feature is meaningful for f2fs project, and there is no=
 obvious<br>
&gt; mistake, e.g. missing some critical path.<br>
<br>
</div>IMO, it is worth to design and implement the inline feature though, I=
&#39;d<br>
like to review the total design before looking at trivial mistakes.<br>
Since if the initial design is changed frequently, we need to review<br>
again and again.<br>
<br></blockquote><div>

<p class=3D""><span lang=3D"EN-US">Agree. So let&#39;s understand/clarify y=
our
following proposal firstly.</span></p>

</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
So, we need to decide the overall inline design.<br>
Currently we have to consider three data structures at a same time for<br>
the on-disk *inline* inode block structure, which are data, dentry, and<br>
xattr as well.<br>
<br>
IMO, we can give three inode flags: F2FS_INLINE_DATA, F2FS_INLINE_DENT,<br>
and F2FS_INLINE_XATTR.<br>
<br></blockquote><div>Small data and dentries can be inline.=C2=A0 And xatt=
r (such as XATTR_USER, XATTR_TRUSTED, eg. ) can be inline too, right ?<br>O=
r inline xattr is just working for inline data/dentries?<br>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">

&lt; on-disk inode block &gt;<br>
=C2=A0- metadata<br>
=C2=A0- if F2FS_INLINE_XATTR is set,<br>
=C2=A0 : use fixed 2*255 bytes to *cache* two xattrs for simplicity<br></bl=
ockquote><div><br>These 2 xattrs are working for the ones storing in xattr_=
nid block before, or just providing info for inline data/dent ? <br><br></d=
iv>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0`- if F2FS_INLINE_DATA is set,<br>
=C2=A0 =C2=A0: use the remained space varied by F2FS_INLINE_XATTR.<br>
=C2=A0`- if F2FS_INLINE_DENT is set,<br>
=C2=A0 =C2=A0: use variable number of dentries determined by F2FS_INLINE_XA=
TTR.<br></blockquote><div>Do you mean inline dent depends on inline xattr, =
that is, we need a dedicated xattr entry providing info for inline denterie=
s, right?<br>
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0`- Otherwise, use as pointers<br>
<br>
And then, we need to define how to deal with their combinations.<br>
<br>
Operational conditions<br>
----------------------<br>
=C2=A0- use inline xattr or not, by checking other inline flags and inline<=
br>
data size.<br>
=C2=A0- calculate inline data size and its offset according to the use of<b=
r>
inline xattrs.<br>
=C2=A0- the places of inline operaions wrt the lock consistency and coverag=
e<br>
=C2=A0- Power-off-recovery routine should care about the on-disk inode<br>
structure.<br>
=C2=A0- unset F2FS_INLINE_DATA if i_size =3D 0<br>
=C2=A0- unset F2FS_INLINE_XATTR if xattr entries =3D 0<br>
=C2=A0- unset F2FS_INLINE_DENT if dentries =3D 0<br>
<br>
=C2=A0- what else?<br></blockquote><div>- clear these flags after the inlin=
e data/dent is moved to normal data block<br>- maybe we need store xattr_he=
ader while making xattr inline. <br><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">

<br>
Once we design the whole thing, we can make general functions to deal<br>
with them gracefully.<br>
<div class=3D"im"><br>
&gt; And if you team has some special opensource test suites used in your d=
aily<br>
&gt; f2fs test cycle, pls. kindly share the info with us, then we can make =
sure our<br>
&gt; patchset can pass these cases before we send out next version.<br>
<br>
</div>1. xfstests for functionality<br>
2. fsstress for deadlock/consistency check<br>
3. power-off with fsstress<br>
<br>
Thanks,<br>
<div class=3D""><div class=3D"h5"><br>
&gt; BTW, test the kernel source tree or kernel build is a good suggestion.=
 thanks.<br>
&gt;<br>
&gt; On Tue, Jun 04, 2013 at 01:23:57PM +0900, Namjae Jeon wrote:<br>
&gt; &gt; Hi. Huajun.<br>
&gt; &gt;<br>
&gt; &gt; I agree jaegeuk&#39;s opinion.<br>
&gt; &gt; Additionally, It is better that you describe the effect in change=
-log<br>
&gt; &gt; when this feature is added to f2fs.<br>
&gt; &gt; e.g.<br>
&gt; &gt; =C2=A0 =C2=A0 1. how much space is saved when storing kernel-tree=
(small files) ?<br>
&gt; &gt; =C2=A0 =C2=A0 2. small files creation performance test.<br>
&gt; &gt; =C2=A0 =C2=A0 3. file look-up performance test.<br>
&gt; &gt; =C2=A0 =C2=A0 4. other performance tools &#39;s result.<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt; 2013/6/4 Jaegeuk Kim &lt;<a href=3D"mailto:jaegeuk.kim@samsung.co=
m">jaegeuk.kim@samsung.com</a>&gt;:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This feature is one of my todo items. ;)<br>
&gt; &gt; &gt; Thank you for the contribution.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Before reviewing the below code intensively, we need to chec=
k the<br>
&gt; &gt; &gt; following issues.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; - deadlock conditions<br>
&gt; &gt; &gt; - FS consistency<br>
&gt; &gt; &gt; - recovery routine<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Could you check one more time?<br>
&gt; &gt; &gt; Thanks again,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; 2013-06-03 (=EC=9B=94), 18:04 +0800, Huajun Li:<br>
&gt; &gt; &gt;&gt; f2fs inode is so large, small files can be stored direct=
ly in the inode,<br>
&gt; &gt; &gt;&gt; rather than just storing a single block address and stor=
ing the data elsewhere.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; This RFC patch set is just to enable f2fs support inline=
 data: files less than<br>
&gt; &gt; &gt;&gt; about 3.6K can be stored directly in inode block.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; TODO: make small dirs inline too.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Haicheng Li (3):<br>
&gt; &gt; &gt;&gt; =C2=A0 f2fs: Add helper functions and flag to support in=
line data<br>
&gt; &gt; &gt;&gt; =C2=A0 f2fs: Add interface for inline data support<br>
&gt; &gt; &gt;&gt; =C2=A0 f2fs: add tracepoints to debug inline data operat=
ions<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Huajun Li (2):<br>
&gt; &gt; &gt;&gt; =C2=A0 f2fs: Handle inline data read and write<br>
&gt; &gt; &gt;&gt; =C2=A0 f2fs: Key functions to handle inline data<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 10 +++<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/data.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 78 +++++++++++++++++++++-<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/f2fs.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 70 +++++++++++++++++++<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/file.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A09 ++-<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/inline.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0156 +++++++++++++++++++++++++++++++++++++++++++<br>
&gt; &gt; &gt;&gt; =C2=A0fs/f2fs/inode.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A08 +++<br>
&gt; &gt; &gt;&gt; =C2=A0include/linux/f2fs_fs.h =C2=A0 =C2=A0 | =C2=A0 =C2=
=A05 ++<br>
&gt; &gt; &gt;&gt; =C2=A0include/trace/events/f2fs.h | =C2=A0 69 ++++++++++=
+++++++++<br>
&gt; &gt; &gt;&gt; =C2=A09 files changed, 402 insertions(+), 4 deletions(-)=
<br>
&gt; &gt; &gt;&gt; =C2=A0create mode 100644 fs/f2fs/inline.c<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; Jaegeuk Kim<br>
&gt; &gt; &gt; Samsung<br>
&gt; &gt; --<br>
&gt; &gt; To unsubscribe from this list: send the line &quot;unsubscribe li=
nux-fsdevel&quot; in<br>
&gt; &gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.=
org">majordomo@vger.kernel.org</a><br>
&gt; &gt; More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/ma=
jordomo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.=
html</a><br>
<br>
</div></div><span class=3D""><font color=3D"#888888">--<br>
Jaegeuk Kim<br>
Samsung<br>
</font></span></blockquote></div><br></div></div>

--20cf307f32e82c164604de9f7238--


--===============4208156267089258283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
--===============4208156267089258283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============4208156267089258283==--
