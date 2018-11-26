From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/7] f2fs: use IS_ENCRYPTED() to check
 encryption status
Date: Sun, 25 Nov 2018 22:41:32 -0500
Message-ID: <20181126034132.GC7904@thunk.org>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-3-chandan@linux.vnet.ibm.com>
 <20181119212332.GB33805@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1gR8Nn-0006XX-9i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 04:20:27 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gR8Nl-00HFNi-CE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 04:20:27 +0000
Content-Disposition: inline
In-Reply-To: <20181119212332.GB33805@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Nov 19, 2018 at 01:23:32PM -0800, Jaegeuk Kim wrote:
> Hi Chandan,
> 
> Let me try to queue and test this patch separately from the patch-set in order
> to avoid merge conflicts. So, I think IS_ENCRYPTED should be merged in f2fs/ext4
> branches, and the others can be applied to fscrypt and fsverity into each trees.

Hi Jaeguk,

What conflicts are you anticipating?  I can't apply the rest of
Chandan's patches without unless we apply them in order, and I'd
prefer to avoid cross-merging, or spreading out this series across two
kernel releases.

						- Ted
