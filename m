From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Tue, 16 Apr 2019 13:39:47 -0700
Message-ID: <20190416203947.GA84362@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
 <CAD14+f1JW6yaJFmuZRU2vJcREXScwm59nRvp1x2Y9Zt6n3MFXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hGUry-0007wy-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 20:39:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGUrx-00ATXC-Dh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 20:39:54 +0000
Content-Disposition: inline
In-Reply-To: <CAD14+f1JW6yaJFmuZRU2vJcREXScwm59nRvp1x2Y9Zt6n3MFXg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Ju Hyung,

On 04/16, Ju Hyung Park wrote:
> Hi Jaegeuk, Chao.
> 
> This is a revival from a patchset I sent about a year ago.
> 
> The original patchset's list was about 50 entries and we talked about
> leaving too small room for the users to customize.
> I made much more conservative choices here to made the new one to be
> 36(from 34), while still being very practical and relevant on both
> regular Linux distros and Android.
> I hope the explanation written in the commit message is enough to persuade you.

Thank you for heads up. Taking a look at two patches, I think it'd be fine to
merge them into single patch. Let me know, if you have any concerns.

Thanks,

> 
> Thanks.
> 
> 
> On Tue, Apr 16, 2019 at 3:44 PM Park Ju Hyung <qkrwngud825@gmail.com> wrote:
> >
> > Following extensions are removed:
> >  - divx: deprecated video format and it's usually wrapped with avi
> >  - asf: deprecated streaming format
> >  - asx: redirecting file to asf(small)
> >  - wmx: redirecting file to wma/wmv(small)
> >  - rm: deprecated media container
> >  - video: unused
> >  - wv: unpopular audio format from 1998
> >
> > The extensions list is limited to 64 and those don't deserve to be
> > on this space-precious list.
> >
> > Common prefixes are introduced and are checked with
> > https://en.wikipedia.org/wiki/List_of_filename_extensions
> > to avoid treating possible hot files as cold:
> >  - mp: covers mp3, mp4, mpeg, mpg
> >  - wm: covers wma, wmb, wmv
> >  - og: covers oga, ogg, ogm, ogv
> >  - jp: covers jpg, jpeg, jp2
> >
> > Following extensions are added:
> >  - webm: extremely popular free media container format from Google
> >          VP8/VP9/AV1 and Vorbis/Opus is often wrapped with this container
> >  - wav: uncompressed audio format, commonly used with voice recorders
> >  - svg: vector image format commonly used in web
> >  - webp: free lossy image format commonly used in web
> >  - jar: Java archive file
> >  - deb: Debian software package
> >  - iso: disk image file
> >  - gz: gzip compressed file, unable to randomly update
> >  - xz: xz compressed file, unable to randomly update
> >  - zst: zstd compressed file, unable to randomly update
> >  - pdf: PDF document
> >  - pyc: Python bytecode automatically generated when
> >         executing python to run .py files
> >  - ttc, ttf: font files
> >  - cnt: image alias files commonly used in Android apps
> >  - exo: EXO player's cache files, commonly used in Android's YouTube app
> >  - odex, vdex: Android RunTime files found in /data/app/*/oat
> >
> > Total entries on the list changed from 34 to 36.
> >
> > Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> > ---
> >  mkfs/f2fs_format.c | 50 ++++++++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 22 deletions(-)
> >
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index 0ae0df3..4560611 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -38,48 +38,54 @@ struct f2fs_checkpoint *cp;
> >  static unsigned int quotatype_bits = 0;
> >
> >  const char *media_ext_lists[] = {
> > +       /* common prefix */
> > +       "mp", // Covers mp3, mp4, mpeg, mpg
> > +       "wm", // Covers wma, wmb, wmv
> > +       "og", // Covers oga, ogg, ogm, ogv
> > +       "jp", // Covers jpg, jpeg, jp2
> > +
> >         /* video */
> >         "avi",
> > -       "divx",
> >         "m4v",
> >         "m4p",
> > -       "mp4",
> > -       "wmv",
> > -       "mpeg",
> >         "mkv",
> >         "mov",
> > -       "asx",
> > -       "asf",
> > -       "wmx",
> > -       "svi",
> > -       "wvx",
> > -       "wm",
> > -       "mpg",
> > -       "mpe",
> > -       "rm",
> > -       "video",
> > +       "webm",
> >
> >         /* audio */
> > +       "wav",
> >         "m4a",
> > -       "mp3",
> >         "3gp",
> > -       "wma",
> > -       "wv",
> > -       "ogg",
> >         "opus",
> >         "flac",
> >
> >         /* image */
> > -       "jpeg",
> > -       "jpg",
> >         "gif",
> >         "png",
> > -
> > -       /* other */
> > +       "svg",
> > +       "webp",
> > +
> > +       /* archives */
> > +       "jar",
> > +       "deb",
> > +       "iso",
> > +       "gz",
> > +       "xz",
> > +       "zst",
> > +
> > +       /* others */
> > +       "pdf",
> > +       "pyc", // Python bytecode
> > +       "ttc",
> > +       "ttf",
> >         "exe",
> >
> >         /* android */
> >         "apk",
> > +       "cnt", // Image alias
> > +       "exo", // YouTube
> > +       "odex", // Android RunTime
> > +       "vdex", // Android RunTime
> >         "so",
> >
> >         NULL
> > --
> > 2.21.0
> >
