Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDCFCDE010
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlIuxjP7xbRO4ikmT1KOTFV+BgKkj6XJhH8j3jCuJOc=; b=F7F85PAJNSzb1eGu3sOYoapggx
	zE50YrPC9sil4mQf2xlqOUHMfguvd4+H5B9Xq8gRdeOsa/YHSzT+gr2Dv4ytDQI3RjXq/Jr7qIudt
	qde7Ze3SZhYnyJZtX4zu09Y1dOVau0BBDdKwkuh4Gl6yGBugNymeMRK5OwHAhIJIqZxA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcyxX-0000wI-A4;
	Fri, 26 Jun 2026 05:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wcyxV-0000wB-91
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Nni3Cjt6/gy9EqzfEsRfHAcblodymGObUrd4uf6lAU=; b=lhM2gxhYYbIwYb7LBos8IyBDV0
 vzluCmzYbnxw0moY0oa5CxGfrdLQeicEFBuku02ertkD8t6yRgnDnvF1RDQOp+LzT9FhjxAgXQHWX
 uOzILKoW9l/4kpNBfTGd4oYf6o8JlGP7pTRFhLx070WI5oPX50BKorOBeUGI3XLV7DBs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+Nni3Cjt6/gy9EqzfEsRfHAcblodymGObUrd4uf6lAU=; b=WWrLj8YkwbkKSfuanhHd5dVPQP
 t8RRKSKJuZP+32Xl9ajLt+89PM33lUvF1gr8HXIQFExI5ilo1f+cpsuRw6wJnLjpEVq5E1III2EW+
 BVc+BVZX+ToB6jwTjeZEbn6WyjymJW2l1HQPaFz1K0pDBx65BMwqB5/NrcU8+hD9+Sd8=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcyxU-0000Q7-2z for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:18:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4FA5C68C4E; Fri, 26 Jun 2026 07:18:20 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:18:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260626051819.GC9043@lst.de>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624050334.124606-4-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wcyxU-0000Q7-2z
Subject: Re: [f2fs-dev] [PATCH 03/16] blk-crypto: Allow control over whether
 hardware is used
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2026 at 10:03:21PM -0700, Eric Biggers wrote:
> fscrypt uses inline encryption hardware only when the "inlinecrypt"
> mount option is given.  I'd like to keep that behavior even after
> standardizing on the blk-crypto API for file contents encryption.  That
> is, the default should continue to be the well-tested CPU-based
> encryption code, and the use of inline encryption hardware should
> continue to be an opt-in feature for systems where it's beneficial and
> has been fully validated (including verifying ciphertext correctness).
> 
> To support this use case, add an allow_hw field to struct
> blk_crypto_config.
> 
> For now it's always set to true.  Later commits will change that.

Maybe a flags argument with a descriptive flag name would be better
than a bool for a public API like this?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
