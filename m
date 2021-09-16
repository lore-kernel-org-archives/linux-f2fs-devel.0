Return-Path: <SRS0=Rvmn=OG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8128EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Sep 2021 14:06:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4170560F93;
	Thu, 16 Sep 2021 14:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4170560F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mQs2Q-0001gK-Qo; Thu, 16 Sep 2021 14:06:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mQs2P-0001g7-Uh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Sep 2021 14:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kuxcpA8S3q9ykbi2+xBsJrqnD3SE1scIiSCr/qpaSfE=; b=VUyFy4iOc7fm1OA3mdRkf78VzM
 vocV+6Vh+gPQBQNaL0jVrX7G+YeWiO8YsWMIoCJY9ceGVvbdza1rG+sK8/OpB+Sc4zENTOzSzdes9
 s8SSih3ezi8aX8OJ6fZZ/bViRejufALlwNljeaNWZKWNVpc1xt2akUByNLRjiWjjUuKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kuxcpA8S3q9ykbi2+xBsJrqnD3SE1scIiSCr/qpaSfE=; b=X+3uy3oUaZHOGMdVFkESk2e8pS
 CEtmfnFhuum6LxaZIqcJlo5O0lULsB5awJ6ObTctC2M1GAHE5AvgvLZ9egcCVqCzH5NCsIWu/4CXY
 6gOrO6s81S97+t2y92+DzSSdl31LJ8pLMhoebHqeF2oHAf/Pxf39FBDiCtWOx7UMYmac=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mQs2P-00Cpbf-El
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Sep 2021 14:06:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B1B060238;
 Thu, 16 Sep 2021 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631801205;
 bh=JdkAm+o+bFathyCWpUUPm0oUpU2tV/07Lu6/E/J0SqQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QslSkK+DWsmffoVCXR9f3NTsSqADgY3jyF6g8V4d4UydbRmybtyPpYoXagnRdJxTW
 YNVwBTdR+aK04iFTKl6PRLMOgLfTkUmS/KLgvjhUmVQEsmziky/84RqLkaSXdgzpZY
 UaGNpLdmram6IE3O7dyoxG+mrybWc4a405IydA3lk72U4IJmJFflTSuftdkWREoCO6
 zV7IVhOImAmolkVZBYXbJqYbafG0fwYzVKOM5BwZHdWdGIEXvdW/gpMwjRcb9MwxIT
 Pk3EZUMWht8hHkU1YhU9EtSIa/gd9d5I+BJqGs25wz8TVlPGCXu2Q6mHncHN6f3rXN
 toGkWRwW32knw==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20210916125520.118196-1-changfengnan@vivo.com>
 <20210916125520.118196-2-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <0b6c58ed-bc4a-eaac-9c41-6fa726b305ca@kernel.org>
Date: Thu, 16 Sep 2021 22:06:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916125520.118196-2-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1mQs2P-00Cpbf-El
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: fix missing inplace count in
 overwrite with direct io
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/16 20:55, Fengnan Chang wrote:
> For now, overwrite file with direct io use inplace policy, but
> not counted, fix it. And use stat_add_inplace_blocks(sbi, 1, )
> instead of stat_inc_inplace_blocks(sb, ).
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
