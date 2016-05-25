From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Tue, 24 May 2016 17:53:50 -0700
Message-ID: <1464137630.2680.17.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160520075849.GA8067@infradead.org>
	 <1463769043.2835.30.camel@slavad-ubuntu-14.04>
	 <20160523082542.GA27833@infradead.org>
	 <1464034085.2658.40.camel@slavad-ubuntu-14.04>
	 <20160524085236.GB8121@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20160524085236.GB8121@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, 2016-05-24 at 01:52 -0700, Christoph Hellwig wrote:
> On Mon, May 23, 2016 at 01:08:05PM -0700, Viacheslav Dubeyko wrote:
> > I think that it's some confusion. I didn't introduce any new fields in
> > struct f2fs_super_block. The "major_ver" and "minor_ver" fields exist in
> > F2FS superblock from the beginning of this file system implementation.
> > The content of these two fields are defined during mkfs phase. The
> > f2fs_format.c contains such code in f2fs_prepare_super_block():
> 
> They exists, but the kernel so far never checked them, and despite
> that the feature checking works fine worth other f2fs features.
> 
> > Current version in VERSION file is 1.6.1. So, historically F2FS is using
> > version of on-disk layout. The suggested patch simply introduces the
> > threshold value F2FS_MAX_SUPP_MAJOR_VERSION with the purpose to refuse
> > the mount operation for the case of unsupported version of on-disk
> > layout.
> 
> While I've never seen an actual piece of documentation for the fields it
> seems so far they just document the version of mkfs used to create
> the file system.  Suddenly overloading them with semantics is just
> going to create problems.
> 

The best way not to create a problem is to do nothing.

The F2FS superblock has "major_ver" and "minor_ver" fields. This
metadata structure is stored into F2FS volume. So, this two fields
define the on-disk layout's version. We are trying to change the on-disk
layout. It means that we need to increase the on-disk layout's version
number and to check the version number, namely. What's wrong with my
logic?

> > First of all, it needs to distinguish two different points. First point,
> > we need to increase the on-disk layout version because we are going to
> > change on-disk layout in the way that old (current) driver will not
> > support.
> 
> That's exactly what most file systems use feature flags for.

Frankly speaking, support of 16TB+ volumes is not a "feature" but simple
bug fix. Because this issue was created during metadata structure
definitions. And we are trying to fix this issue right now. And this
issue is on-disk layout related issue. So, the key point here is not a
feature flag but the on-disk layout's version, from my point of view.

Thanks,
Vyacheslav Dubeyko.


