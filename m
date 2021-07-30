Return-Path: <SRS0=ah6d=MW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2822EC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jul 2021 23:41:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E350A60EE2;
	Fri, 30 Jul 2021 23:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E350A60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9c8G-0006ty-F0; Fri, 30 Jul 2021 23:41:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m9c8F-0006tl-2w
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 23:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dBi7PUBE2gAdvWe3vzHih6pDhoOWgVe0oOpHF6CMmv0=; b=OiSWuBP2B+96q+QUIhG/N5N/0q
 en1j121SNNknnYY/3QhB7sB2adJtjtFbsqgVOuBEZyz7T1Z7pq3Vxkly8FrLFXK1FRUJOt5EJ+gjL
 X2O1fgxr+NdesjYmNi4v4wNsWV9t6dmVya9lha2WWBst0JXfrc8OJlNpYhKc7HZQxNtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dBi7PUBE2gAdvWe3vzHih6pDhoOWgVe0oOpHF6CMmv0=; b=Cw5UgKRrcqvz1t1tgvZ8C05QGK
 DETuD5/ks7m94sX4sXqjUuo9pJDg/B3LXFxDntsgWdDNuyp6LlqoSE7lER/WIkh56y8FFGcjMGJiD
 JyShO5+Gg4BGDlNkezZ7p2D9GnZAAPN39pyi3p2R8OdQDv/aXC+ezCfT80axyWFl3eEU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9c8D-0006gg-LN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Jul 2021 23:41:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B779660EE2;
 Fri, 30 Jul 2021 23:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627688478;
 bh=dBi7PUBE2gAdvWe3vzHih6pDhoOWgVe0oOpHF6CMmv0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K5bSvfe73MQxuPsUIQtW18p5P4kjucbXM28QkJf0LkNCJjBnF5y2tgrNNnXc7DbNw
 LzcNrLEA9+GD8aC0Y+BvuUId8xztzSYG4bya5iSwkx0Nr63cX5qXlCGNn6vphomzET
 esMGkYdMNV6XaCUZMGKs6i2r1qX7FIjZvJYe0IzvEW1h5KHwk3JrBAyZg5MPQCNVD4
 2xpjuORpF0QBWyO4oYvVoajlMD3OvBK1q46GjDc4zZ78q+EZkmPdDUegnpQzXqvODN
 XwToiCiXhT0UKH+UcOQogQ/sVKiHz9C0SvUCj/LvcdKfFwmPslduNajAFGEaM6jAXg
 rYhA7gktPFZ6w==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
Date: Sat, 31 Jul 2021 07:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQREtmDLBNKSQViC@google.com>
Content-Language: en-US
X-Headers-End: 1m9c8D-0006gg-LN
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce nosmall_discard mount option
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/31 2:28, Jaegeuk Kim wrote:
> how about adding "discard_gran=[small|segment|section]", and keeping discard_map
> in the small case only? And, I think we should set the section mode for zoned
> device automatically.

Yup, better,

About the naming, it look discard_gran is not clear here, since there is another
sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
also semantics of newly added mount option is not only control the smallest discard
size, but also indicate discard start offset should be aligned to segment or section.
So how about using: "aligned_discard=[none|segment|section]" instead?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
