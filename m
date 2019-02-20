From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH 00/10] Consolidate Post read processing
 code
Date: Tue, 19 Feb 2019 16:41:07 -0800
Message-ID: <20190220004107.GI12177@gmail.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gwFwq-0003jN-IW
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 00:41:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwFwp-001SFM-9W
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 00:41:16 +0000
Content-Disposition: inline
In-Reply-To: <20190218100433.20048-1-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.ibm.com>
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

On Mon, Feb 18, 2019 at 03:34:23PM +0530, Chandan Rajendra wrote:
> Based on the reviews provided for this patchset, I
> will change F2FS to use mpage_readpage[s] and post the next version of
> this patchset to linux-fsdevel mailing list.

Is that really possible?  F2FS has other functionality in its ->readpages(),
such as support for filesystems that use multiple block devices.

- Eric
