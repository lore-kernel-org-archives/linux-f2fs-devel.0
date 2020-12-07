Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8CFC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 07:42:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFC5205CB;
	Mon,  7 Dec 2020 07:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFC5205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmB9t-0006w6-0L; Mon, 07 Dec 2020 07:42:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kmB9q-0006vc-8B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 07:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RFy8miP19TUobx6GiD064J5PKwgHsfbzoa0P2q8xfIM=; b=maxK3mI9r4c7QeKG0nwFbQmSW+
 U1S7MPul3hMeOjC3ARFBX23jA9fXK+ci55WlMhkd6oUJQPUof9mkrzn1I21PujlaeRHL/Z3UIaBES
 eE/xVvE4l1CTBSNwr2PXOtSeIlSt6+wWTYOdNhbdCTzKyBzaf30dIonZucjfIDWZMwwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RFy8miP19TUobx6GiD064J5PKwgHsfbzoa0P2q8xfIM=; b=AHH+3Yhfw16xhmEJK1AGwAFjsA
 YGAvy/krq94zPy61ATy/viMbEX/nJDmrcEJLMXXefvrDmtEeT61diH20B7eSXNBQm3T8T5F84tQ2h
 u1ca8tvxz2eEXo504LFzXZpaVaQ4dmCs0RsriiJPyOJenpzPul2dHEdsHskd49dK4s7M=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmB9k-001f1b-RD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 07:42:06 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqFc92nSPzhnbZ;
 Mon,  7 Dec 2020 15:41:13 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 7 Dec 2020
 15:41:39 +0800
To: Daeho Jeong <daeho43@gmail.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
 <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
Date: Mon, 7 Dec 2020 15:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kmB9k-001f1b-RD
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/12/7 15:28, Daeho Jeong wrote:
>> It looks like it will be better to move this into merge condition?
>>
>>                  if (bio && (!page_is_mergeable(sbi, bio,
>>                                          *last_block_in_bio, blkaddr) ||
>>                      !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL) ||
>>                          f2fs_verify_mergeable_bio())) {
>>
> 
> I tried this for the first time, but it requires unnecessary checks
> within the compression cluster.

We only need to check f2fs_verify_mergeable_bio for i == 0 case? something like:

static bool f2fs_verify_mergeable_bio(struct bio *bio, bool verify, bool first_page)
{
	if (!first_page)
		return false;
	if (!verify)
		return false;

	ctx = bio->bi_private;
	if (!(ctx->enabled_steps & (1 << STEP_VERITY)))
		return true;
}

Thoughts?

> I wanted to just check one time in the beginning of the cluster.
> What do you think?

It's trivial, but I'm think about the readability... at least, one line comment
is needed to describe why we submit previous bio. :)

Thanks,

> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
