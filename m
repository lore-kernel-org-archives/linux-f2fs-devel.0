From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Wed, 25 May 2016 10:46:25 -0700
Message-ID: <1464198385.2648.10.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160523211357.GA17297@jaegeuk.gateway>
	 <1464138323.2680.27.camel@slavad-ubuntu-14.04>
	 <20160525171246.GC47096@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525171246.GC47096@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, 2016-05-25 at 10:12 -0700, Jaegeuk Kim wrote:

[snipped]
> > 
> > So, my logic is simple. We are trying to modify the on-disk layout. As a
> > result, we need to check the on-disk layout version, from my viewpoint.
> > And this modification is not "feature" itself but simple bug fix. And I
> > believe that "major_ver", "minor_ver" in F2FS superblock is the on-disk
> > layout version.
> 
> Hmm, the versions are to indicate f2fs-tools, not on-disk layout something.
> They are simply growing as whatever reasons such as bug fixes, new features,
> and so on to provide debugging information.
> 

OK. If you need to know the version of f2fs-tools then you will try to
extract the version from f2fs-tools itself. And it is possible to track
bug fixes and the new features by means of git repository. The every
release of Linus kernel has own version number. So, again, it's easy to
track bug fixes and new features by means of Linux kernel git
repository. Moreover, struct f2fs_super_block has "version" and
"init_version" fields. These fields store kernel version again. So, it's
really easy to track kernel version and the rest stuff. It's really
crappy way to duplicate information in superblock and to store
f2fs-tools version in the superblock. The really important information
is the on-disk layout version. And f2fs-tools should follow the on-disk
layout version namely.

What do you think?

Thanks,
Vyacheslav Dubeyko.
