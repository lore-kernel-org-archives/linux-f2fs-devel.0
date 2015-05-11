From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 16/18] f2fs crypto: add symlink encryption
Date: Sun, 10 May 2015 22:15:31 -0700
Message-ID: <20150511051531.GB7675@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
 <20150509042554.GN889@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150509042554.GN889@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Uday Savagaonkar <savagaon@google.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, May 09, 2015 at 05:25:54AM +0100, Al Viro wrote:
> On Fri, May 08, 2015 at 09:20:51PM -0700, Jaegeuk Kim wrote:
> > This patch implements encryption support for symlink.
> > 
> > The codes refered the ext4 symlink path.
> 
> ext4 symlink patches are seriously misguided - don't mix encrypted and
> unencrypted cases in the same inode_operations.

Ok. Let me split them into separated inode_operations.

Thanks,

> 
> NAK.
