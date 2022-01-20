Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65E6C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jan 2022 08:28:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nASoF-0008RR-Si; Thu, 20 Jan 2022 08:28:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+0328028a7a74e2859a11+6724+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nASoD-0008RE-OB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 08:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/j3ZP5oOwU7RB5jo7ROztDrujmjBt8BH3fryKjW5QLk=; b=BcdgB20ftFmrrwE+VdIxtxeYTI
 tmuJf5b4GCWdQU+KSRdGnsN94ckJ/1B4zxHHrCWUAPJqwHCZRlp9oHQaDR7RJuI1mXDGHjwAmlpPM
 B+6j/KyBKytxRl3zmksBxn4oRygY2SUWqz0w96v3bjWbsmptPTzgveu+vxa5Mx/hRYck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/j3ZP5oOwU7RB5jo7ROztDrujmjBt8BH3fryKjW5QLk=; b=HpwIsGFvvJD3iURW76bZP4bq1p
 JFLpqgm7IQ/ztMNcallGo7EbqN8mj7XG474T0Ah6PeRs6kkfZ+BSvotK2/4drVsKAUcV95qiDIJTf
 9yf5ERT075u5C0rUTYOL7TeIjs4s+/LWzHPuBaOO/bsLuwH/HD9xvEaDJo353FoP5TiA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nASoC-004f8w-1T
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Jan 2022 08:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/j3ZP5oOwU7RB5jo7ROztDrujmjBt8BH3fryKjW5QLk=; b=zVTuEpUT8AVEBvWepzTiACcSeE
 6SYmFVQ78Xb/5MjcwEglnGTgt5JQq3wg47vlzYW/O0tJcfuMXsfqrWAW0lNQoicKacUhHOv35qjZh
 S1s3wDJM3ghHTiOTbnqt0XJiijgtUU5S94zbes1s965OrRXCnBAyo6DWRCEBZZgntK7rusmo4Lv7l
 q0J9kX3RaffAFv3uH5WvmGHFc6iNuyFYufwrnWgFS5un3mhRp9SlqRcAvzl5+kASyO50V4RRlPBK8
 05INttOpWuKQW01uYZ6rc2kCMCBTZcXo8t5dPya6BgGQ2mYY5MyYrD8dPIUC2CzqwLTk229Plpj/Y
 xt5H2Heg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nASo6-009l59-0Q; Thu, 20 Jan 2022 08:28:34 +0000
Date: Thu, 20 Jan 2022 00:28:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YekdMU8W7jzwY/88@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220120071215.123274-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nASoC-004f8w-1T
Subject: Re: [f2fs-dev] [PATCH v10 2/5] iomap: support direct I/O with
 fscrypt using blk-crypto
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
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Satya Tangirala <satyat@google.com>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 19, 2022 at 11:12:12PM -0800, Eric Biggers wrote:
>  	bio = bio_alloc(GFP_KERNEL, 1);
> +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +				  GFP_KERNEL);

Note that this will create a (harmless) conflict with my
"improve the bio allocation interface" series.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
