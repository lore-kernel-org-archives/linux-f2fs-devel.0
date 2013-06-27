From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: add sysfs support for controlling the gc_thread
Date: Thu, 27 Jun 2013 14:24:36 +0900
Message-ID: <1372310676.28480.89.camel@kjgkr>
References: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
 <1369619214.10521.25.camel@kjgkr>
 <CAKYAXd_QZronHD536LOfeFWLmtCoweRq3gbH94R4_7oKC7hv3w@mail.gmail.com>
 <1369704867.10521.46.camel@kjgkr>
 <CAKYAXd-OO5niMiFv+ysStw=c-NQXT4AkTz3m7o1wTRZRd=WYFw@mail.gmail.com>
 <1372140227.28480.69.camel@kjgkr>
 <CAKYAXd-NEKCuEyoLwWHLrN165yq7EKRRcz9RknfdbR5EOO6cvQ@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd-NEKCuEyoLwWHLrN165yq7EKRRcz9RknfdbR5EOO6cvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-06-26 (=EC=88=98), 14:10 +0900, Namjae Jeon:
> 2013/6/25, Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> >> > - any priority scheme for cleaning?
> >> Could you plz tell me a little more detail ?
> >
> > I meant, as well as the GC times, user also gives a kind of status =
like:
> > LONG_IDLE, SHORT_IDLE, something like that.
> > Therefore, how about using this information to select a victim sele=
ction
> > policy between cost-benefit and greedy algorithms?
> currently we will provide the option of updating the time values from
> the =E2=80=98sysfs=E2=80=99 interface, and the GC policy is selected =
by default from
> GC thread based upon the gc type, BG or FG.
> So, do you mean we should provide an option to select the default GC
> policy for the user using =E2=80=98sysfs=E2=80=99 interface? Like, if=
 the user sets
> =E2=80=9CLONG_IDLE=E2=80=9D =E2=80=93 we choose Cost Benefit and in c=
ase of SHORT_IDLE
> =E2=80=9CGreedy=E2=80=9D ? Please elaborate more on this.

Yes, exact.
=46or example, if an user configures a small period of GC interval but
gives LONG_IDLE, we can choose cost-benefit.
But, if SHORT_IDLE is given with a long GC period, we need to choose
greedy.
How do you think?
Thanks,

--=20
Jaegeuk Kim
Samsung
