From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: add sysfs support for controlling the gc_thread
Date: Tue, 25 Jun 2013 15:03:47 +0900
Message-ID: <1372140227.28480.69.camel@kjgkr>
References: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
 <1369619214.10521.25.camel@kjgkr>
 <CAKYAXd_QZronHD536LOfeFWLmtCoweRq3gbH94R4_7oKC7hv3w@mail.gmail.com>
 <1369704867.10521.46.camel@kjgkr>
 <CAKYAXd-OO5niMiFv+ysStw=c-NQXT4AkTz3m7o1wTRZRd=WYFw@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd-OO5niMiFv+ysStw=c-NQXT4AkTz3m7o1wTRZRd=WYFw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Namjae,

Sorry for the late reply.

2013-05-29 (=EC=88=98), 09:01 +0900, Namjae Jeon:
> >> I have thought more after getting your reply.
> >> f2fs_cleaner(a tentative name) is that provide the following sever=
al
> >> options to control gc thread.
> >> 1. start forground gc thread to clean all invalid blocks.
> >> 2. stop number 1(fg) working.
> >> 3. set new tunning parameter (min/max/no_gc).
> >> 4. get status of current f2fs.
> >> We will provide user level util in f2fs tools and sysfs at the sam=
e time.
> >> It is useful if the console level user/App user can change them ea=
sily.

I think we'd better support configurable min/max/no_gc times only.
And I don't think users need to do foreground GCs explicitly, since
foreground GCs should be done only when the file system suffers from th=
e
shortage of free space. The foreground GC is the most costly operation
so that I'd like to avoid triggering it as much as possible even if
users want to do.

Otherwise, if users would like to move data, they can just adjust
background GC times appropriately and then do sync if they really move
data synchronously.

> >>
> >> >
> >> > Afterwards, it is worth to add some information to
> >> > Document/filesystems/f2fs.txt.
> >> Yes, It will be included in next series patches.
> >> How do you think ? If you agree my suggestion, I will start to wor=
k
> >> the above jobs.
> Hi. Jaegeuk.
> >
> > As I described, basically I agreed that this kind of interfaces and=
 user
> > apps are definitely beneficial to the f2fs users.
> >
> > But wrt design and implementation of new interfaces, we'd better di=
scuss
> > how to use them in more detail and what information should be neede=
d for
> > user-made cleaner.
> > After then, we'd better start to design the interfaces as well as u=
ser
> > scenarios clearly.
> Okay. I agree.
>=20
> >
> > IMO, the following issues should be addressed.
> > - how to know system idle time by users?
> e.g. When playing PVR function, In case of DTV, App try to read data
> from filesystem of usb device.
> now that, user app will never access flash rw partition and don't nee=
d
> to access there.
> I think that we can cleverly use such time to avoid or make slowly
> come in the possible performance regression later.

Okay.

>=20
> > - any priority scheme for cleaning?
> Could you plz tell me a little more detail ?

I meant, as well as the GC times, user also gives a kind of status like=
:
LONG_IDLE, SHORT_IDLE, something like that.
Therefore, how about using this information to select a victim selectio=
n
policy between cost-benefit and greedy algorithms?

>=20
> > - what status of current f2fs?
> I think that we can get this information how many victim section and
> segment is possible to reclaim in sysfs.
> It will be easily interpreted by the user and it allows the user the
> freedom to check itself if really running GC is useful
> and user can decide to run cleaner at timing they want.
>=20
> > - how about supporting that f2fs controls gc times dynamically inst=
ead
> > of the user decision?
> Yes, I thought such idea before. It might be useful if gc thread can
> dynamically control own gc times with different partition size and
> available size.
> But I think there is a limitation that f2fs don't predict when user a=
ccess f2fs.
> So I think that user level controller surely is needed.
> Ah,, And It will be also useful if f2fs is mounted with background_gc=
_off.

Okay.
Thanks, :)

>=20
> Let me know your opinion~.
>=20
> Thanks:)
> >
> > Thanks,
> >
> >>
> >> Let me know your opinion.
> >>
> >> Thanks.
> >> >
> >> > Thanks,
> >> >
> >
> > --
> > Jaegeuk Kim
> > Samsung
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdev=
el" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jaegeuk Kim
Samsung
