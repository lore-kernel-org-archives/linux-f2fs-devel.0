Return-Path: <SRS0=hEcs=VA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B2EC5B57D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:25:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EF1206A3;
	Wed,  3 Jul 2019 01:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hblBsFGg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="El0IwTUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EF1206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiU1U-0006OW-GZ; Wed, 03 Jul 2019 01:25:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hiU1S-0006OL-SZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 01:25:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TsnjYM2WH0fHZ1BtDel6UR7xCLzcERfL2rup6mVYknE=; b=hblBsFGg6ldlW3SI8WQ7NN1ZIq
 XrXS8kOpNu3W1SCtS460M1V6vVlqEXk/1ES226SuuESiZSwbThZb7Y+CrUTtDokeJ82guyAswLyHi
 XXj715Vu675DNzNpdVcW8xQkxsf23PlfKIRcNG1TB5b9oh1IwX7pKRQblPIejn1RCLqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TsnjYM2WH0fHZ1BtDel6UR7xCLzcERfL2rup6mVYknE=; b=El0IwTUUmM4ExmHnSyV7riRbHf
 YFrXzHc0K0ntH0RvpLMIK4kRaar3m+rhuY0t8gRrisMCxe7n02FfFCEPDeNTvz7cUC+aCdskkRR2C
 o7p2tHMChP2uFFjkh8vUQ6600ntoU1/SA1Xv59w4GZN04xHwk39D3EHs8lW5uAjqB5nw=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hiU1h-003VWS-5D
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jul 2019 01:25:39 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D2E50B732F0DD8067CD1;
 Wed,  3 Jul 2019 09:25:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 09:25:24 +0800
To: Eric Biggers <ebiggers@kernel.org>, <linux-fscrypt@vger.kernel.org>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-18-ebiggers@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b9b6d387-b893-18cc-b574-7775607ec5b3@huawei.com>
Date: Wed, 3 Jul 2019 09:25:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701153237.1777-18-ebiggers@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hiU1h-003VWS-5D
Subject: Re: [f2fs-dev] [PATCH v6 17/17] f2fs: add fs-verity support
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org, Linus
 Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/7/1 23:32, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add fs-verity support to f2fs.  fs-verity is a filesystem feature that
> enables transparent integrity protection and authentication of read-only
> files.  It uses a dm-verity like mechanism at the file level: a Merkle
> tree is used to verify any block in the file in log(filesize) time.  It
> is implemented mainly by helper functions in fs/verity/.  See
> Documentation/filesystems/fsverity.rst for the full documentation.
> 
> The f2fs support for fs-verity consists of:
> 
> - Adding a filesystem feature flag and an inode flag for fs-verity.
> 
> - Implementing the fsverity_operations to support enabling verity on an
>   inode and reading/writing the verity metadata.
> 
> - Updating ->readpages() to verify data as it's read from verity files
>   and to support reading verity metadata pages.
> 
> - Updating ->write_begin(), ->write_end(), and ->writepages() to support
>   writing verity metadata pages.
> 
> - Calling the fs-verity hooks for ->open(), ->setattr(), and ->ioctl().
> 
> Like ext4, f2fs stores the verity metadata (Merkle tree and
> fsverity_descriptor) past the end of the file, starting at the first 64K
> boundary beyond i_size.  This approach works because (a) verity files
> are readonly, and (b) pages fully beyond i_size aren't visible to
> userspace but can be read/written internally by f2fs with only some
> relatively small changes to f2fs.  Extended attributes cannot be used
> because (a) f2fs limits the total size of an inode's xattr entries to
> 4096 bytes, which wouldn't be enough for even a single Merkle tree
> block, and (b) f2fs encryption doesn't encrypt xattrs, yet the verity
> metadata *must* be encrypted when the file is because it contains hashes
> of the plaintext data.
> 
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
