From: Eugene Syromyatnikov <evgsyr@gmail.com>
Subject: Re: [PATCH 2/2] statx.2: add project support update
Date: Mon, 4 Mar 2019 23:56:09 +0100
Message-ID: <CACGkJdsdVPKNOnhuAza=Lnh1b=KW2N2yycp6YxJ2tsLFxWJiYg@mail.gmail.com>
References: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
 <1551449184-7942-3-git-send-email-wshilong1991@gmail.com>
 <CAKgNAkitiDEYSZDnJ5iQ6coaE=q45BHxnG2z_bZtWs=kk+2g3w@mail.gmail.com>
 <20190304205006.GX23020@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <evgsyr@gmail.com>) id 1h0wVR-0007s9-CX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:56:21 +0000
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1h0wVP-00AfXE-HW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:56:21 +0000
Received: by mail-io1-f65.google.com with SMTP id r136so5380659iod.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 Mar 2019 14:56:19 -0800 (PST)
In-Reply-To: <20190304205006.GX23020@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: Andreas Dilger <adilger@dilger.ca>, linux-man <linux-man@vger.kernel.org>, Wang Shilong <wshilong@ddn.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, lixi@ddn.com, Wang Shilong <wangshilong1991@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, xfs <linux-xfs@vger.kernel.org>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>

On Mon, Mar 4, 2019 at 9:57 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Mar 04, 2019 at 02:52:59PM +0100, Michael Kerrisk (man-pages) wrote:
> > Hello Wang Shilong,
> >
> > On Fri, 1 Mar 2019 at 15:06, Wang Shilong <wangshilong1991@gmail.com> wrote:
> > >
> > > From: Wang Shilong <wshilong@ddn.com>
> >
> > I take it that these patches relate to some API changes that are not
> > yet merged into the kernel, right?
> >
> > Also, I think we need some accompanying info to describe project IDs.
> > Can you point me at any documents/resources?
>
> Probably "best" documented in the man pages that ship with xfsprogs.
> Basically, it's just another quota ID that can be used to account
> for files/directories in arbitrary admin defined groups. i.e. quotas
> that aren't bound by user/group identities.
>
> $ man 8 xfs_quota
> $ man 5 projects
> $ man 5 projid

Project quotas also mentioned in quotactl(2).

-- 
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}
