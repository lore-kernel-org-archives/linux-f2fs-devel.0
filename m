Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F53C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Jul 2026 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jdi+1UGOMdKGP7ntm6VLM5l6s72Xyx2wW5SeKFfDzAU=; b=d88SI/vPa4m1/6Gbo0tKn8Bi/r
	rjArgwTYxzr0frId3evGQWyWLTMUhdiLBv5wjt9kHlvt2HKnEAD99fSUPfCGBpF5OooWD5xgnLsWm
	r2ZYgqSrv/vCAVVj36PgwEBZHi/tgZtVyutEa0IAwkKMjB2GO/U1mNGlV04R/Ek4NxFc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlLme-0001lM-9q;
	Sun, 19 Jul 2026 07:17:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wlLmc-0001lC-MJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:17:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ov08yvGtWw3dxwliGz6MHO4uj0XtDIs8Kop7RqOjyE0=; b=PHmec3rNnJATGftwRiihsISlUC
 BLpiA5TlJSPm4wDphA/5ESXq5qa+Iuo6EkIyzLvUEv9dM1qKgCWZLYnMRTYIN7PTOLx/qoOK5rF26
 24jWc0RsebNRNWiE/DyDWLL+7oUvSA7FGUg39s1psKa6EKabSmBMkKmwtPGh75Nae29g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ov08yvGtWw3dxwliGz6MHO4uj0XtDIs8Kop7RqOjyE0=; b=gRBPDnuBJpM/BrESvnHAa2YhAy
 l1+C+chXgM0l2jC/EbZ+afDUKAFHx9V57wYlFGLGQfKBqPUA5lbxfeHwwnea78RgZJIqRjOddgbH6
 7fD1WGyTVtdEc562bvTQVwUBcI/tgnV/40IyPhkQ5S2iy3tWmqihlPUrYZUWt0MDmcrA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlLmd-0005c7-05 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Jul 2026 07:17:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BFCB6001A;
 Sun, 19 Jul 2026 07:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9AC1F00A3A;
 Sun, 19 Jul 2026 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784445468;
 bh=ov08yvGtWw3dxwliGz6MHO4uj0XtDIs8Kop7RqOjyE0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=P7KfFtFEi1mBVAs5V7fYN5lMRn1Csg1W4ByemGDsGQ3b8p4uEvKIrXuH2+ZI0BJQ1
 zlxspdjz0X8m2tGf/n8o7ve1IYfleKpNiPMNmqX5s71CjpwN0WjT5DJ2vY4qa+6ngu
 5NSCdywkB5ltGZDzJSEGLD6WEFEekINO3+v5/QBsOIezag/Y44IJMWWTAE0w1XkR32
 0tG9maf1mqKvzc+H7XV5tpnGqFFIO+wvokQc/vyUkzPd908vn22K7oWE3Veu+3+cWm
 k+XlwALBn5ySAGfG3w+9r62YWsRNfgrWt4eHdQT///8l4tj5fp3tMSL3u2WCtWYRlN
 1G2oXbHg9LoRg==
Message-ID: <8f354c53-18d9-4cf2-8ca6-e7476210c171@kernel.org>
Date: Sun, 19 Jul 2026 15:17:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guanghui Yang <3497809730@qq.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_E3A22766836A9AE740D1CEF328C4DB8D0805@qq.com>
X-Headers-End: 1wlLmd-0005c7-05
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix dentry folio leak in find_in_level
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/13/26 14:36, Guanghui Yang wrote:
> find_in_level() gets a dentry folio with f2fs_find_data_folio() before
> calling find_in_block().  If find_in_block() returns an error, the
> function stores the error in res_folio and breaks out of the loop without
> dropping the dentry folio.
> 
> This leaks the folio reference on the find_in_block() error path.  Drop
> the dentry folio before returning the error to the caller.
> 

Need fixes and Cc stable lines.

> Signed-off-by: Guanghui Yang <3497809730@qq.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
