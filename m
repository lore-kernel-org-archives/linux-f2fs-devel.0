From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Mon, 23 May 2016 13:08:05 -0700
Message-ID: <1464034085.2658.40.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160520075849.GA8067@infradead.org>
	 <1463769043.2835.30.camel@slavad-ubuntu-14.04>
	 <20160523082542.GA27833@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160523082542.GA27833@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, 2016-05-23 at 01:25 -0700, Christoph Hellwig wrote:
> On Fri, May 20, 2016 at 11:30:43AM -0700, Viacheslav Dubeyko wrote:
> > I am not sure that I follow to your point. The F2FS has "feature" field
> > (__le32 feature) into on-disk superblock (struct f2fs_super_block). The
> > suggested patch introduces the new F2FS_FEATURE_16TB_SUPPORT flag. And
> > it looks like as your comment.
> 
> It does, but at the same time you also introduce a major version
> superblock
> field.

I think that it's some confusion. I didn't introduce any new fields in
struct f2fs_super_block. The "major_ver" and "minor_ver" fields exist in
F2FS superblock from the beginning of this file system implementation.
The content of these two fields are defined during mkfs phase. The
f2fs_format.c contains such code in f2fs_prepare_super_block():

set_sb(major_ver, F2FS_MAJOR_VERSION);
set_sb(minor_ver, F2FS_MINOR_VERSION);

The F2FS_MAJOR_VERSION and F2FS_MINOR_VERSION are defined into
configure.ac as:

m4_define([f2fs_tools_version], m4_esyscmd([sed -n '1p' VERSION | tr -d '\n']))

AC_DEFINE([F2FS_MAJOR_VERSION], m4_bpatsubst(f2fs_tools_version,
                                [\([0-9]*\)\(\w\|\W\)*], [\1]),
                                [Major version for f2fs-tools])
AC_DEFINE([F2FS_MINOR_VERSION], m4_bpatsubst(f2fs_tools_version,
                                [\([0-9]*\).\([0-9]*\)\(\w\|\W\)*], [\2]),
                                [Minor version for f2fs-tools])

Current version in VERSION file is 1.6.1. So, historically F2FS is using
version of on-disk layout. The suggested patch simply introduces the
threshold value F2FS_MAX_SUPP_MAJOR_VERSION with the purpose to refuse
the mount operation for the case of unsupported version of on-disk
layout.

> 
> > So, necessary changes in on-disk layout for 16+TB volumes support will
> > be incompatible with current available version of F2FS driver. It means
> > that, anyway, we need to increase version of on-disk layout (major_ver
> > of struct f2fs_super_block). The presence of superblock's version and
> > F2FS_FEATURE_16TB_SUPPORT flag will be very useful for consistency
> > checking by fsck tool.
> 
> Why is the feature not enough for that?

First of all, it needs to distinguish two different points. First point,
we need to increase the on-disk layout version because we are going to
change on-disk layout in the way that old (current) driver will not
support. Second point, we need to introduce the new feature flag. But
features could be different. One feature doesn't need in on-disk layout
change but another one could require in on-disk layout modification. So,
we need in version change and new feature introduction for the case of
necessity to modify the on-disk layout.

So, I think that it's something wrong to have "major_ver" and
"minor_ver" fields in the superblock, to define these fields during mkfs
phase and not to check this version during mount operation. First of
all, to check the on-disk layout version during mount operation is the
proper activity, from my point of view. Secondly, if we have
incompatible versions of on-disk layouts then the version should be
checked at first. And, finally, I believe that feature flag should exist
for 16TB+ support too. The version is more important for this
modification but the presence of special feature flag will clearly show
the support of 16TB+ volumes.

I think that F2FS architecture and code state is the reason why we need
to increase the on-disk layout version and to introduce feature flag.

Thanks,
Vyacheslav Dubeyko.
