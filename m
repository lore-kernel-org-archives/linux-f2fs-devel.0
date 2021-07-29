Return-Path: <SRS0=A5bl=MV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B438C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 01:24:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2FD6101C;
	Thu, 29 Jul 2021 01:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F2FD6101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m8un2-0007RI-Jn; Thu, 29 Jul 2021 01:24:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1m8un1-0007RA-I6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 01:24:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G4T/5cXN2gE8sWc8LKYuJ+ZF84Ee+3515AVQDi+teQk=; b=ajDZkHQ6RvIb7Zyd/LtdPep3MY
 56DTDYbwnZAULrubdDvHHUkjHmt5133mNzxZ6zQA2skZhdVbGVj7wnTB6XsOqt5+2zVEertrgBwD3
 +qqGPfJuEQYHTqklDs2xDZrAyUkU53FaS8T/+2SlE5gZZ5ZjyJJh62olSZvLSu/+jb/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G4T/5cXN2gE8sWc8LKYuJ+ZF84Ee+3515AVQDi+teQk=; b=f63jGRqs8F4km3gJXeknwoWs2E
 G+9f7YmsDSbI/vcNlW2Czof9yBLNIZ3Nvyg/Y4CtWPDd0pvWHfWcJ4XbsDg2NWr9IKj2xe0WDhd/u
 +IxqTKwbXUeNzMo0UzjZ3guUAsmNkdSyQbtBPsy8XVCq2u5qxaZ3Q0Qx+R1Fh+qkVblk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m8umv-0000ki-9n
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 01:24:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5F5A6103A;
 Thu, 29 Jul 2021 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627521875;
 bh=zsscGp2pw3XigcjWcGqfP+E4pheV41KtdZi8NPO57rI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kaSgNl7lu5P6hqO+euR6hUW6g9kk2GX5sOF8VTP4zHFcNsxZANC1hH2Oqk+dBzv5k
 Hjsm8a2jIajLPs0b80dJWz5laDhD/bodv2mPiT7iY8zv+uNKcjoADD0oEwZqH/Y6dW
 tE310XTb8iuPD88i3W3/EJTWWZqKiJK5u8+CKJWs2OWXerJ89Kfm57yVyXnGIcYbMZ
 YKYCV79Kys/dic9Ca4NtMwOkalgnIIqumYjTSeebtGEhKtS3HHFc4m3Tgy+cGgCT0f
 BPRSKeMpMPspPTG05Yavsz+7LbP2pIyJ2qhisN5vi94VrrbMqCdrffqjthvkN+arIy
 vqAWwyry3uuYw==
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210728193811.2519412-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <56598a72-92d8-b571-550a-26830d7f5b2f@kernel.org>
Date: Thu, 29 Jul 2021 09:24:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728193811.2519412-1-daeho43@gmail.com>
Content-Language: en-US
X-Headers-End: 1m8umv-0000ki-9n
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: turn back remapped address in
 compressed page endio
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/29 3:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Turned back the remmaped sector address to the address in the partition,
> when ending io, for compress cache to work properly.
> 
> Fixes: 6ce19aff0b8c ("f2fs: compress: add compress_inode to cache
> compressed blocks")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Hyeong Jun Kim <hj514.kim@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
