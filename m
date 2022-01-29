Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A3EC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Jan 2022 06:29:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nDhF5-0004N9-RT; Sat, 29 Jan 2022 06:29:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nDhF4-0004N3-BP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jan 2022 06:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AyHpzQkb1nucmjT1w1/IoOuCRn0Ri2qD8FDfXDDojYs=; b=NmTeUsp7Y8feoAPgTu6czN8Zs9
 zXhLTzL/j/hCCIhNJ7eoEwIUWK3gRZAxXXdb3Z3l54Qr0peOPNd4aO0PdDzRSeGw/44dW9OqBgk0O
 hamWJhXU/aL/ewNVAX/grwrVyh4WrJ3HxwDwUEHJZcoSh1VOb7mvwM4mNlhFiygpag7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AyHpzQkb1nucmjT1w1/IoOuCRn0Ri2qD8FDfXDDojYs=; b=JCZlaP/zi7/kXVW0rNgIdJ0Hky
 38ecPPwTreo5lsivhIa/PKd2qVI6CQemDgJNgNDPCDb+BulQKiU/9M8Eq7sbS+LLReMn+kX9Y2Dip
 UpkSRoY7KoO0XZu3dceEpihxplrJo5KYqocAfEWQinRqYQXb7+XX0GT0g6GcFUKugqhg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nDhF2-002AIX-3x
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jan 2022 06:29:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9209608C3;
 Sat, 29 Jan 2022 06:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F351CC340E5;
 Sat, 29 Jan 2022 06:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643437770;
 bh=qAe52EceE/ZktnrH9t02qqOXkPJeOr1aXAVgzP7cj1s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bGKgZgJapdwZZigk69QJrsUoRNGVRRFET8AAL6Y+oKdKrkyRdxu/AmwxR0JbhL/ma
 E4RfESH84YE6mos2ScF7QSudz2QkyQBseJiZmuij1QHj+efDjkQng6SG4lWXNPBJ10
 0XgcRCNwW/7/lWWWJh0SCclO3wYv6zash/PlhcFccphRLNI9tfMvAVks1xyX26Ec8j
 meFAP93pem50jSF3QZzlJZLQaqacCwTCXITQEgi3SopPGjOpQBoTKCwO9Btd0hlAGa
 eNwcEwpZrQHNtPEGl8hh2Xmby6ZASRJyYf6c/equNhcjWXhdlTYRIY8gxBQTUCdQxm
 +xrLyO0QUmAWA==
Message-ID: <513a1ad8-20b1-96a3-54c9-a8ce8773a087@kernel.org>
Date: Sat, 29 Jan 2022 14:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220125202254.3111474-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220125202254.3111474-1-jaegeuk@kernel.org>
X-Headers-End: 1nDhF2-002AIX-3x
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: move discard parameters into
 discard_cmd_control
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
Cc: Konstantin Vyshetsky <vkon@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/1/26 4:22, Jaegeuk Kim wrote:
> From: Konstantin Vyshetsky <vkon@google.com>
> 
> This patch unifies parameters related to how often discard is issued and
> how many requests go out at the same time by placing them in
> discard_cmd_control. The move will allow the parameters to be modified
> in the future without relying on hard-coded values.
> 
> Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
