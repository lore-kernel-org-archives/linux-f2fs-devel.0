From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: Re: safety of save_env
Date: Wed, 24 Aug 2016 11:27:19 +0200
Message-ID: <CAN9vWDKh0C5iRN7xx3XGkfdD1jmi5q3tXQOciKOM7RqO1oURBA@mail.gmail.com>
References: <CAN9vWDLM7pSmijHAFpgAZRGOVX3BdhESRnrWvx80Btt3teuOEA@mail.gmail.com>
	<d0fb3d5c-100e-08ec-10be-7697a3922702@gmail.com>
	<CAN9vWDKdAxb=1edAN0bUcu8V6VmVGf3rL1SCpGBJa2doA_8XUw@mail.gmail.com>
	<5c877f46-a894-357d-b542-fd5792946ec6@gmail.com>
	<1a4f93ac-40fd-afd9-25de-84facaf3bbe0@gmail.com>
Reply-To: The development of GNU GRUB <grub-devel@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6681671066726790779=="
Return-path: <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
In-Reply-To: <1a4f93ac-40fd-afd9-25de-84facaf3bbe0@gmail.com>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/grub-devel/>
List-Post: <mailto:grub-devel@gnu.org>
List-Help: <mailto:grub-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/grub-devel>,
	<mailto:grub-devel-request@gnu.org?subject=subscribe>
Errors-To: grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org
Sender: "Grub-devel" <grub-devel-bounces+gcbgd-grub-devel=m.gmane.org@gnu.org>
To: The development of GNU GRUB <grub-devel@gnu.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

--===============6681671066726790779==
Content-Type: multipart/alternative; boundary=94eb2c1309d64e5845053acde3a4

--94eb2c1309d64e5845053acde3a4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Note that it depends on explicit fs driver support; looking e.g. at f2fs
> patch inline data bypasses read hook. Probably not an issue for 100M
> file though.
that probably has to be fixed then.

> Speaking about f2fs - does it use checksums for data or metadata? In
> particular, if supporting block lists for inline data metadata checksums
> may be an issue then.
@Jaegeuk Kim

> Also I understand that it is designed for media which may not support
> direct sector size write, or am I wrong?
@Jaegeuk Kim

> Hmm ... inode checksums do mean problem for ext4 with inline data (not
> yet in GRUB upstream).
Can all the problems you've listed be detected? If so we can just deny
writing if a specific fs feature is enabled.


On Wed, Aug 24, 2016 at 10:10 AM, Andrei Borzenkov <arvidjaar@gmail.com>
wrote:

> 24.08.2016 10:17, Andrei Borzenkov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 24.08.2016 07:15, Michael Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> I mean safe in the sense that it would not destroy data outside of tha=
t
> >> file (no matter if writing was successful or not) or even destroy/add
> >> errors to  the filesystem.(ext*, f2fs, fat*, ...).
> >>
> >
> > It computes block list of file data and then overwrites these blocks. I=
t
> > will abort if file is sparse. It actually even double checks block list
> > by reading directly from disk (bypassing filesystem driver) and
> > comparing results.
> >
> > So it looks reasonably safe in that it should not write outside of spac=
e
> > already allocated for file data on disk. It obviously will not work for
> > filesystem that computes checksums over data like btrfs or zfs; these
> > filesystems currently ignore read hooks so always return empty block
> > list (leading to confusing error message).
> >
> > For journalled filesystems there is non-zero probability that journal
> > replay will change content of those blocks.
> >
> > Note that it depends on explicit fs driver support; looking e.g. at f2f=
s
> > patch inline data bypasses read hook. Probably not an issue for 100M
> > file though.
> >
>
> Speaking about f2fs - does it use checksums for data or metadata? In
> particular, if supporting block lists for inline data metadata checksums
> may be an issue then.
>
> Also I understand that it is designed for media which may not support
> direct sector size write, or am I wrong?
>
> Hmm ... inode checksums do mean problem for ext4 with inline data (not
> yet in GRUB upstream).
>
> >> On Tue, Aug 23, 2016 at 9:59 PM, Andrei Borzenkov <arvidjaar@gmail.com=
>
> >> wrote:
> >>
> >>> 23.08.2016 21:51, Michael Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> Hi,
> >>>>
> >>>> how safe is the usage of save_env? I'm considering writing like 100M=
B
> to
> >>> a
> >>>> loop file using the technique used by this command.
> >>>>
> >>>
> >>> Define "safe". Command is filesystem agnostic and expects fully
> >>> preallocated file; it writes on block level. It also builds full
> content
> >>> of environment file in memory before writing it out; so it may fail o=
n
> >>> systems with small amount of memory.
> >>>
> >>> It attempts to verify that file can be represented by block lists and
> it
> >>> does not overwrite blocks outside of allocated for the file.
> >>>
> >>> _______________________________________________
> >>> Grub-devel mailing list
> >>> Grub-devel@gnu.org
> >>> https://lists.gnu.org/mailman/listinfo/grub-devel
> >>>
> >>
> >>
> >>
> >> _______________________________________________
> >> Grub-devel mailing list
> >> Grub-devel@gnu.org
> >> https://lists.gnu.org/mailman/listinfo/grub-devel
> >>
> >
>
>
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel
>

--94eb2c1309d64e5845053acde3a4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;=C2=A0<span style=3D"font-size:12.8px">Note that it de=
pends on explicit fs driver support; looking e.g. at f2fs</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&gt; patch inline da=
ta bypasses read hook. Probably not an issue for 100M</span><br style=3D"fo=
nt-size:12.8px"><span style=3D"font-size:12.8px">&gt; file though.</span><d=
iv style=3D"font-size:12.8px"></div><div>that probably has to be fixed then=
.</div><div><br></div><div><span style=3D"font-size:12.8px">&gt; Speaking a=
bout f2fs - does it use checksums for data or metadata? In</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&gt;=C2=A0</span><sp=
an style=3D"font-size:12.8px">particular, if supporting block lists for inl=
ine data metadata checksums</span><br style=3D"font-size:12.8px"><span styl=
e=3D"font-size:12.8px">&gt;=C2=A0</span><span style=3D"font-size:12.8px">ma=
y be an issue then.</span></div><div>@Jaegeuk Kim</div><div><br style=3D"fo=
nt-size:12.8px"><span style=3D"font-size:12.8px">&gt; Also I understand tha=
t it is designed for media which may not support</span><br style=3D"font-si=
ze:12.8px"><span style=3D"font-size:12.8px">&gt;=C2=A0</span><span style=3D=
"font-size:12.8px">direct sector size write, or am I wrong?</span></div><di=
v>@Jaegeuk Kim<span style=3D"font-size:12.8px"><br></span></div><div><br st=
yle=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&gt; Hmm ... inod=
e checksums do mean problem for ext4 with inline data (not</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">&gt; yet in GRUB ups=
tream).</span><br></div><div><span style=3D"font-size:12.8px">Can all the p=
roblems you&#39;ve listed be detected? If so we can just deny writing if a =
specific fs feature is enabled.</span></div><div><br></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Aug 24, 2016 at 10:=
10 AM, Andrei Borzenkov <span dir=3D"ltr">&lt;<a href=3D"mailto:arvidjaar@g=
mail.com" target=3D"_blank">arvidjaar@gmail.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><a href=3D"tel:24.08.2016%2010" value=3D"+1240=
8201610">24.08.2016 10</a>:17, Andrei Borzenkov =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:<br>
<span class=3D"">&gt; <a href=3D"tel:24.08.2016%2007" value=3D"+12408201607=
">24.08.2016 07</a>:15, Michael Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=D1=82:<=
br>
&gt;&gt; I mean safe in the sense that it would not destroy data outside of=
 that<br>
&gt;&gt; file (no matter if writing was successful or not) or even destroy/=
add<br>
&gt;&gt; errors to=C2=A0 the filesystem.(ext*, f2fs, fat*, ...).<br>
&gt;&gt;<br>
&gt;<br>
&gt; It computes block list of file data and then overwrites these blocks. =
It<br>
&gt; will abort if file is sparse. It actually even double checks block lis=
t<br>
&gt; by reading directly from disk (bypassing filesystem driver) and<br>
&gt; comparing results.<br>
&gt;<br>
&gt; So it looks reasonably safe in that it should not write outside of spa=
ce<br>
&gt; already allocated for file data on disk. It obviously will not work fo=
r<br>
&gt; filesystem that computes checksums over data like btrfs or zfs; these<=
br>
&gt; filesystems currently ignore read hooks so always return empty block<b=
r>
&gt; list (leading to confusing error message).<br>
&gt;<br>
&gt; For journalled filesystems there is non-zero probability that journal<=
br>
&gt; replay will change content of those blocks.<br>
&gt;<br>
&gt; Note that it depends on explicit fs driver support; looking e.g. at f2=
fs<br>
&gt; patch inline data bypasses read hook. Probably not an issue for 100M<b=
r>
&gt; file though.<br>
&gt;<br>
<br>
</span>Speaking about f2fs - does it use checksums for data or metadata? In=
<br>
particular, if supporting block lists for inline data metadata checksums<br=
>
may be an issue then.<br>
<br>
Also I understand that it is designed for media which may not support<br>
direct sector size write, or am I wrong?<br>
<br>
Hmm ... inode checksums do mean problem for ext4 with inline data (not<br>
yet in GRUB upstream).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;&gt; On Tue, Aug 23, 2016 at 9:59 PM, Andrei Borzenkov &lt;<a href=3D"m=
ailto:arvidjaar@gmail.com">arvidjaar@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; 23.08.2016 21:51, Michael Zimmermann =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:<br>
&gt;&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; how safe is the usage of save_env? I&#39;m considering wri=
ting like 100MB to<br>
&gt;&gt;&gt; a<br>
&gt;&gt;&gt;&gt; loop file using the technique used by this command.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Define &quot;safe&quot;. Command is filesystem agnostic and ex=
pects fully<br>
&gt;&gt;&gt; preallocated file; it writes on block level. It also builds fu=
ll content<br>
&gt;&gt;&gt; of environment file in memory before writing it out; so it may=
 fail on<br>
&gt;&gt;&gt; systems with small amount of memory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It attempts to verify that file can be represented by block li=
sts and it<br>
&gt;&gt;&gt; does not overwrite blocks outside of allocated for the file.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; Grub-devel mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:Grub-devel@gnu.org">Grub-devel@gnu.org</a><b=
r>
&gt;&gt;&gt; <a href=3D"https://lists.gnu.org/mailman/listinfo/grub-devel" =
rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/mailman/<wbr>lis=
tinfo/grub-devel</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt; Grub-devel mailing list<br>
&gt;&gt; <a href=3D"mailto:Grub-devel@gnu.org">Grub-devel@gnu.org</a><br>
&gt;&gt; <a href=3D"https://lists.gnu.org/mailman/listinfo/grub-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/mailman/<wbr>listin=
fo/grub-devel</a><br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
______________________________<wbr>_________________<br>
Grub-devel mailing list<br>
<a href=3D"mailto:Grub-devel@gnu.org">Grub-devel@gnu.org</a><br>
<a href=3D"https://lists.gnu.org/mailman/listinfo/grub-devel" rel=3D"norefe=
rrer" target=3D"_blank">https://lists.gnu.org/mailman/<wbr>listinfo/grub-de=
vel</a><br>
</div></div></blockquote></div><br></div>

--94eb2c1309d64e5845053acde3a4--


--===============6681671066726790779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Grub-devel mailing list
Grub-devel@gnu.org
https://lists.gnu.org/mailman/listinfo/grub-devel

--===============6681671066726790779==--
