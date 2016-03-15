From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: support access control via key management
Date: Tue, 15 Mar 2016 00:24:22 -0700
Message-ID: <20160315072422.GB11669@infradead.org>
References: <1457571168-56724-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457571168-56724-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Mar 09, 2016 at 04:52:48PM -0800, Jaegeuk Kim wrote:
> Through this patch, user can assign its key into a specific normal files.
> Then, other users who do not have that key cannot open the files.
> Later, owner can drop its key from the files for other users to access
> the files again.

No magic file system specific access control, please:

Nacked-by: Christoph Hellwig <hch@lst.de>
