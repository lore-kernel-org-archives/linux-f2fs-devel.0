Return-Path: <SRS0=edr7=LZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB37DC11F64
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jul 2021 14:41:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D256140C;
	Thu,  1 Jul 2021 14:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D256140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyxsW-0006qO-9X; Thu, 01 Jul 2021 14:41:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1lyxsU-0006qB-Pz
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0tPCTN0NSpB9Fn5vIfv6Yop2TjEBva60c5sFIEvk0E0=; b=XX60HiXw4DdbJKZwLlE2WAlnnH
 6EyLn5VB6/uqIu23RoMINBDzjp/5Bs2h+IqYTnGjlxRd/wUGA4MzF/ET5O4Z7acgb78XBSk9jXBfG
 9KIadabrfpJFCDbPrVZ3qDHe6KPRQfMDKN+LdSFU7ofB3cCdbqGJiQmgBaZdsl1O20Fo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0tPCTN0NSpB9Fn5vIfv6Yop2TjEBva60c5sFIEvk0E0=; b=YCsACZV5nPeZqx7+OWIJlSumgb
 omjDwKXkGrcq5pZ40RGWg6tUGD8CmEwyCQiUqGWQWadw5qEBGVT5DEg0GPDl+e/QpMsJJXKx8lFs1
 6YqsGf40JupP+GY66jtgIG3RaS8q2pkqKqlTKIreWMhUZ9t4SOv5BcJsqQ/fPUzqBExk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lyxsJ-0067LI-NB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:41:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8885B6140C;
 Thu,  1 Jul 2021 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625150451;
 bh=qRA6jix9tJ9GFuDWO6ZTcbnyF4vlIVI6z2/rj74g4BY=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=QNDj4qPVAmQzw7Kb5gvI5wgLPcwoNWfwmk+4LOIFlgi/Pp1YeV7GuM7suSnUqUTD4
 MaRQyN6hI9Rpfi0SllaxZ8hSbuzHQ4hvQ68QeEPIySmW0z/yK32S/9LElZCXiOYmZl
 XYADxpQ5xrkrsApJ9BkB4bS3naeyxIMru9QGgShGJvIYdlA7fAZdT+PZ27tUHrP0sm
 8dBAkqNNfe5EzDV2s97jqk6HBT+uaDY8r3zDGqha8sVnBth19BL/wbbTIhfqqTdM/2
 rcy8TqLSbI/D5nyk5JdMWFYwAIVlLsMlkwnUjiEqlChzQQtLu8HKDBFanVFpa0MQGN
 IJcob9zbEcz5Q==
To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-3-sunke32@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <e7122925-de26-65ae-6f13-91d6d66d4355@kernel.org>
Date: Thu, 1 Jul 2021 22:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-3-sunke32@huawei.com>
Content-Language: en-US
X-Headers-End: 1lyxsJ-0067LI-NB
Subject: Re: [f2fs-dev] [PATCH v3 2/3] generic/103: special left calculation
 for f2fs
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
Cc: guan@eryu.me, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/30 19:37, Sun Ke wrote:
> It failed on f2fs:
>        QA output created by 103
>       +fallocate: No space left on device
>        Silence is golden.
>       ...
> 
> f2fs uses index(radix) tree as mapping metadata, its space overhead
> is about one thousandth of the data.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
