From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 16/18] f2fs crypto: add symlink encryption
Date: Sat, 9 May 2015 05:25:54 +0100
Message-ID: <20150509042554.GN889@ZenIV.linux.org.uk>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Uday Savagaonkar <savagaon@google.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, May 08, 2015 at 09:20:51PM -0700, Jaegeuk Kim wrote:
> This patch implements encryption support for symlink.
> 
> The codes refered the ext4 symlink path.

ext4 symlink patches are seriously misguided - don't mix encrypted and
unencrypted cases in the same inode_operations.

NAK.
