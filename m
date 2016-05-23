From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Mon, 23 May 2016 01:25:42 -0700
Message-ID: <20160523082542.GA27833@infradead.org>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
 <20160520075849.GA8067@infradead.org>
 <1463769043.2835.30.camel@slavad-ubuntu-14.04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463769043.2835.30.camel@slavad-ubuntu-14.04>
Sender: linux-kernel-owner@vger.kernel.org
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 20, 2016 at 11:30:43AM -0700, Viacheslav Dubeyko wrote:
> I am not sure that I follow to your point. The F2FS has "feature" field
> (__le32 feature) into on-disk superblock (struct f2fs_super_block). The
> suggested patch introduces the new F2FS_FEATURE_16TB_SUPPORT flag. And
> it looks like as your comment.

It does, but at the same time you also introduce a major version
superblock
field.

> So, necessary changes in on-disk layout for 16+TB volumes support will
> be incompatible with current available version of F2FS driver. It means
> that, anyway, we need to increase version of on-disk layout (major_ver
> of struct f2fs_super_block). The presence of superblock's version and
> F2FS_FEATURE_16TB_SUPPORT flag will be very useful for consistency
> checking by fsck tool.

Why is the feature not enough for that?
