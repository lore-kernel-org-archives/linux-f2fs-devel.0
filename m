Return-Path: <SRS0=Aiq0=MR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4742C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Jul 2021 10:00:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E860EB4;
	Sun, 25 Jul 2021 10:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D0E860EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m7awG-0002zK-TI; Sun, 25 Jul 2021 10:00:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1m7awE-0002zB-BH
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Jul 2021 10:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c/JJja6M/4eW6LRc7LnQAQHdYv1wmipAzy6Fc7gEwfQ=; b=AdHEfYY5obqSU6goD/lJpKjno2
 IsZqPw+wOj7SMMrJy89k4pkPv+zL+U1teyQfdOkQ8FWsa3QHTyv6g0iscw1dY9221ubs7ZI7rx91v
 bMHGEs+bYAt/sC2wE1WO3nQUjXSVt536NIhmilyCNXqRkWDiTjkciiykhY5hQa0aV6UU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c/JJja6M/4eW6LRc7LnQAQHdYv1wmipAzy6Fc7gEwfQ=; b=LqQHfGPGEJUNhxNX+hp/tbAM5i
 WqwXjWWljuVnGLsOTXeXJ0ROwN9fn2YZFWsTKFve/wkAZrcKEKt4RxHLQqadhPJcfkaQ2gyLZULOB
 /XWsnaJfYzE38mDnfc31WR52yppZ4GyOwFgMopLoA85Nb3avyD7WiWO7m06UoAo3u7SU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m7avv-00225J-2Y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 25 Jul 2021 10:00:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F4560C51;
 Sun, 25 Jul 2021 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627207225;
 bh=x7k4bz7Y7uiJ9HuwIGC00aa9QqIdMDVb+kj05Oe8caQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K9xh3UjE9h8p4mNba4tJb72qMolVr5FH3ck2XHfJC3Nq04ce2eNk/tWZvYXz09Xa4
 +iI6mJ90H2NO+S//WQjEpIA7XrQYfP831fQ0DmDfswAZvUdfBVU3UVjkxpgYhxTvi5
 lZhDdEBVy61QSDHoJGEAc1B2kXpVIzulRFjasgiCNcKoGPiYDkI1fgZsMQjI8YgeDl
 TtQPELL26wKbWqPPLasBDRNXpx4fiZPjnA2J3xmL4mlkQpsuerCiCsRR6l4Y9MmGya
 rogIhPCQ1fgY+drq8dJVV4V/uBQH8/2i/YE78Ibc15+7mq+hGPP8xBm5m+vyyIGoa0
 ZW9XoygA98WSw==
To: Eric Biggers <ebiggers@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-2-ebiggers@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <7bc676f9-dbaf-5c8d-2b6e-67c75383d02d@kernel.org>
Date: Sun, 25 Jul 2021 18:00:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716143919.44373-2-ebiggers@kernel.org>
Content-Language: en-US
X-Headers-End: 1m7avv-00225J-2Y
Subject: Re: [f2fs-dev] [PATCH 1/9] f2fs: make f2fs_write_failed() take
 struct inode
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 Matthew Bobrowski <mbobrowski@mbobrowski.org>,
 Satya Tangirala <satyaprateek2357@gmail.com>,
 Changheun Lee <nanich.lee@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/16 22:39, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make f2fs_write_failed() take a 'struct inode' directly rather than a
> 'struct address_space', as this simplifies it slightly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
