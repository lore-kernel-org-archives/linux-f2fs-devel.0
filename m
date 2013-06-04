From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: Re: [RFC 0/5] Enable f2fs support inline data
Date: Tue, 4 Jun 2013 14:01:20 +0800
Message-ID: <20130604060119.GA3265@hli22-desktop>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
 <1370312366.3600.3.camel@kjgkr>
 <CAKYAXd-87rGatnEC8wbocR_wt6Qdpec3HzZaH9ukpzmst6DK=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKYAXd-87rGatnEC8wbocR_wt6Qdpec3HzZaH9ukpzmst6DK=A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Huajun Li <huajun.li@intel.com>, jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com, namjae.jeon@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk & Namjae,

Sure, we'll address your comments. And this version is RFC, just wanna =
to
make sure this feature is meaningful for f2fs project, and there is no =
obvious
mistake, e.g. missing some critical path.

And if you team has some special opensource test suites used in your da=
ily
f2fs test cycle, pls. kindly share the info with us, then we can make s=
ure our
patchset can pass these cases before we send out next version.

BTW, test the kernel source tree or kernel build is a good suggestion. =
thanks.

On Tue, Jun 04, 2013 at 01:23:57PM +0900, Namjae Jeon wrote:
> Hi. Huajun.
>=20
> I agree jaegeuk's opinion.
> Additionally, It is better that you describe the effect in change-log
> when this feature is added to f2fs.
> e.g.
>     1. how much space is saved when storing kernel-tree(small files) =
?
>     2. small files creation performance test.
>     3. file look-up performance test.
>     4. other performance tools 's result.
>=20
> Thanks.
>=20
> 2013/6/4 Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> > Hi,
> >
> > This feature is one of my todo items. ;)
> > Thank you for the contribution.
> >
> > Before reviewing the below code intensively, we need to check the
> > following issues.
> >
> > - deadlock conditions
> > - FS consistency
> > - recovery routine
> >
> > Could you check one more time?
> > Thanks again,
> >
> > 2013-06-03 (=EC=9B=94), 18:04 +0800, Huajun Li:
> >> f2fs inode is so large, small files can be stored directly in the =
inode,
> >> rather than just storing a single block address and storing the da=
ta elsewhere.
> >>
> >> This RFC patch set is just to enable f2fs support inline data: fil=
es less than
> >> about 3.6K can be stored directly in inode block.
> >>
> >> TODO: make small dirs inline too.
> >>
> >>
> >> Haicheng Li (3):
> >>   f2fs: Add helper functions and flag to support inline data
> >>   f2fs: Add interface for inline data support
> >>   f2fs: add tracepoints to debug inline data operations
> >>
> >> Huajun Li (2):
> >>   f2fs: Handle inline data read and write
> >>   f2fs: Key functions to handle inline data
> >>
> >>  fs/f2fs/Kconfig             |   10 +++
> >>  fs/f2fs/Makefile            |    1 +
> >>  fs/f2fs/data.c              |   78 +++++++++++++++++++++-
> >>  fs/f2fs/f2fs.h              |   70 +++++++++++++++++++
> >>  fs/f2fs/file.c              |    9 ++-
> >>  fs/f2fs/inline.c            |  156 ++++++++++++++++++++++++++++++=
+++++++++++++
> >>  fs/f2fs/inode.c             |    8 +++
> >>  include/linux/f2fs_fs.h     |    5 ++
> >>  include/trace/events/f2fs.h |   69 +++++++++++++++++++
> >>  9 files changed, 402 insertions(+), 4 deletions(-)
> >>  create mode 100644 fs/f2fs/inline.c
> >>
> >
> > --
> > Jaegeuk Kim
> > Samsung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdev=
el" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
