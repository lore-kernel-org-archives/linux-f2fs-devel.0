Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB82C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Nov 2022 14:20:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oyD5r-0004VS-Ab;
	Thu, 24 Nov 2022 14:20:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oyD5q-0004VM-9y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WzeQPBFAnb3liq6sAjrmOwlMhKj06aOb6b7j+UoRBw0=; b=MmOcEmE6W8+Nl4IbR7oQd7ecrp
 b6X4KrAyQ0v30BAS/mRWwnXh/hS0rySuyjm5dBg9hhwYgU17gpoh8XUE9WrsYaoQNeepv0Nirb9Bk
 1223raEUn3vA6gv8ibSUZxIFgTYInQhf1uAvVPCcyyIXZcWr9YZ9c9K9GKQU2vJMqPmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WzeQPBFAnb3liq6sAjrmOwlMhKj06aOb6b7j+UoRBw0=; b=R8OvLBz7QB+HUcGvpcUDGhqfaP
 Fjq5cj8gMKfKJKgAvnJ1B7y4qNs5MYXh3lKjOBrieF3ErwAqt+aBNzYb0uSKlrJb6KXo4T/tBeuoh
 ob3YlT4dE1Y8U76s3+nj8B2Dpg8bEyLXiJdEgpOhH4E7TIQwI7j99IZN2tl/zPKmMV0U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oyD5p-004nwq-NX for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:20:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5679362168;
 Thu, 24 Nov 2022 14:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D37C433C1;
 Thu, 24 Nov 2022 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669299639;
 bh=y6/6LAuFshGeZ0qLXCTwAJcGoMYAgHfKsQPtZ2Jy0qk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gqYCgwlFIId5oIl8xoQkCeI8rfJ7HREhKUcymKDux9rnWjrBnR1vKRb14WZR2zGd6
 SxaJE9emEQbpcrO1wDLJ8edDWjLQNTknI+Mc6/bAox3+DdOZ405gvp2WJ/O0L6pGPG
 CpQ70PyA1WuT65/sSOj97fdMYvEErhG6HF+XMgfkowl+q+KvZsffZ+Lh1OasuJOLg7
 UQfaiHbX8os9FZapiUDkSlHuA20orGsqYyJqMXsdZ1AnWh+UpfFZHT/nMDs/dCQCMJ
 QkRTl4mzSsXg/b6P3wcO9rePrhDp8j7exPnvm58MBCLFix0iH3c+HgIixeMFV1qDJ0
 QCg/CVOs4ICdA==
Message-ID: <0aeb33c2-8970-e9ef-7b18-7ba1197a5a0f@kernel.org>
Date: Thu, 24 Nov 2022 22:20:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221118034600.59489-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221118034600.59489-1-frank.li@vivo.com>
X-Headers-End: 1oyD5p-004nwq-NX
Subject: Re: [f2fs-dev] [PATCH] f2fs: init discard policy after thread wakeup
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/18 11:46, Yangtao Li wrote:
> Under the current logic, after the discard thread wakes up, it will not
> run according to the expected policy, but will use the expected policy
> before sleep. Move the strategy selection to after the thread wakes up,
> so that the running state of the thread meets expectations.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
