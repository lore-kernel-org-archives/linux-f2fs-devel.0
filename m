Return-Path: <SRS0=2MSU=LB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC752C47095
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Jun 2021 13:58:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7017D61107;
	Mon,  7 Jun 2021 13:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7017D61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lqFlS-0008Mh-TL; Mon, 07 Jun 2021 13:58:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1lqFlR-0008MR-KY
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 13:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YF9im155pTWoPHQ2T0vYFfmcC5l0oA+f+mUdvcpXwf4=; b=jsbttAeXpSq9gKMJKl8qRxPCvV
 64oov3k0kTDihduryWEluEBNsvuEvT4f1JYkwOi4x+MNWx/2pjYIgG+s/LHvyneYvekLEVZ9XJ6In
 Ji3o68kxUIYrue7j2iE8SntgySOsNlAyELDPmj31o9yEgwbZ4ScDRGZh49HBTIe0XkAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YF9im155pTWoPHQ2T0vYFfmcC5l0oA+f+mUdvcpXwf4=; b=bHpUdviChw/OXJZlzi6tQqYZoy
 j1UV9JClyNEXv/oX/hETe9jDZJmlylSwkCiT/5PQgsAtrBpw4IVe0uT6ZKIIrPqnYxXNpQOC4rz5n
 zf3neBBhzjh8O8DvOZWVghCz81WWIlPR4pfBuR18xiJxALjFF3VoTcyEpvv05c81xl/I=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lqFlP-00065u-6z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jun 2021 13:58:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC8A60FF0;
 Mon,  7 Jun 2021 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623074274;
 bh=PpzF3zWAl8Xl1TXx6+EAS7kLqch5FlBePP3ou+vk7Ug=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=rXjQyMsxFA7O5vsEx2sM/b/mez3iFLAqAsIDt7RDs2kPS3WrJUbu+eiJSItSOYhfE
 JVT+e54LgAesk4Rs7PHPMOMbalbhoYT4+WYvfXjQSQBAZhhygswFBKD9zz9Nkwss1J
 Y3Fb78kOTyeT0Zi3IYobvC7QmDJN/z7vu1nPBeSsdXXaJowHwGcUb5UQIggeb9Ln0G
 0R6t3S1tO0lMpE/RvMzo+qhm61NOFLxdPgKLXef1dil9ahti3bREfbZNCosYdZc9Qj
 tgFvn6fITewnr61IBhcU6VpefoMnwCVJIk0+7PiKRAqAH0mvh8Nd1Kfb1dl4MAi1sK
 ZtjiPpI1PQMyw==
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-2-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <b6c48972-7135-cec7-60d0-e6c067505052@kernel.org>
Date: Mon, 7 Jun 2021 21:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605003210.856458-2-jaegeuk@kernel.org>
Content-Language: en-US
X-Headers-End: 1lqFlP-00065u-6z
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: add pin_file in feature list
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/5 8:32, Jaegeuk Kim wrote:
> This patch adds missing pin_file feature supported by kernel.
> 
> Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
