Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22BEC761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 01:19:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkalO-0007Jb-Cm;
	Fri, 07 Apr 2023 01:19:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pkalM-0007JU-Qa
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 01:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HgRNU0olYIuZgW5ztzXa8olfg4wrHE25BEMsBEkglfk=; b=PAejD81za31kjY4trrYA6WRLsQ
 OGbdH5VKDSGLDHZM4+wyuY423uVWE7Lc33PV0kLLc27vCdC00d0tQjqao+lPVkk/J9HgWwu4jPnAC
 KD5v+PAUhgJ4adxGNckW0MFaVXpeIsg8aMLc70Z1mZWm0oNbyqi5oU7pvbCOLzSErL+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HgRNU0olYIuZgW5ztzXa8olfg4wrHE25BEMsBEkglfk=; b=Ix2wbJHtQyODddkFoi6h5qwpEZ
 G3xQSJIXupqhREQYtNdrk5uq9QvvW8YfAdVCsp3pzPzIUBV4EKCAKw4rjV5s7Ss3sJ3POiF8Mt+lG
 BrQa8usdr74mfivJ623Oj0cG8Q1q7RHPpm7cxQAHl2atAU1h2cbzT9JdTJ7b4xxGpXuk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkalL-0002tE-B7 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 01:19:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B990462D10;
 Fri,  7 Apr 2023 01:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38023C433D2;
 Fri,  7 Apr 2023 01:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680830366;
 bh=sWBOrgUvTwEAppSzsnslf21eHkkDl0tRxVxaz0TgKZA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MIoHW32RpbpDagzVhAkSyBjvx3IcOTgSA4rBAVmSk7KO0kGiqruv1DQFK0jpy9jBG
 +Nmh2bMocQNIjwtpiKbbT20t5AH0TXwzT6AR2VpOP9MaiaTHLshRlCbvqXJop4PVlE
 IfZI/9ZPpcK9tZdCLWNuLFwmrG6SVE0k+cw5sFlbVai96sFPFajXj/Cv0RAbZjz90T
 BEb+b2oq3BihHqTizSemOry7vGopuLmBtfLiaM505fjVDq/WXl+0q1ZyIwkHKJbsf1
 zx1ZWOeCPhtcZP1SBtO3bh8eKYNwA1dLemNYCheYlKOVaBY09xO42MWydsl+0iEjzb
 VwWukVBZXpQkQ==
Message-ID: <53fe1610-895b-04c6-48a2-61918b21aed7@kernel.org>
Date: Fri, 7 Apr 2023 09:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230404032844.3596879-1-o451686892@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230404032844.3596879-1-o451686892@gmail.com>
X-Headers-End: 1pkalL-0002tE-B7
Subject: Re: [f2fs-dev] [PATCH] f2fs: use common implementation of file type
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

On 2023/4/4 11:28, Weizhao Ouyang wrote:
> Use common implementation of file type conversion helpers.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
