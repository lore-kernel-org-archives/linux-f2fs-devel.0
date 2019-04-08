From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 0/5] fscrypt: d_revalidate fixes and
 cleanups
Date: Mon, 08 Apr 2019 10:22:32 +0200
Message-ID: <1872467.qaoHDzFeKg@blindfold>
References: <20190320183913.12686-1-ebiggers@kernel.org>
 <20190401171119.GC131675@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1hDPYE-0002hH-Qe
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Apr 2019 08:22:46 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDPYA-006bXV-L1
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Apr 2019 08:22:46 +0000
In-Reply-To: <20190401171119.GC131675@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org, Sarthak Kukreti <sarthakkukreti@chromium.org>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org

Am Montag, 1. April 2019, 19:11:21 CEST schrieb Eric Biggers:
 > Any more comments on these patches?  I'd like to apply them to the fscrypt tree
> for 5.2.  Richard, can you check whether these solve your overlayfs use case?
> Also, patch 5 could use Acks from ext4, f2fs, and ubifs people.

Will check this week, traveling right now.

Thanks,
//richard
