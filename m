Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4ACC636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Feb 2023 12:34:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPNAo-0002dn-3Z;
	Tue, 07 Feb 2023 12:34:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pPNAm-0002dg-5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 12:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/mD8xqUtuS1X/1BVvAUAYNhqf5YduJDI4/XoYdIVPw=; b=VeoYACYRdph+d5oAOZZrC5aQd4
 Z/V3h81s+yCSNc138oSWBsh9zYoBStuk/vjPPueRwOkJopFoRRTDZgMNPw2rWlQyEo5vwYnyLI49z
 hBHE2odi+q6mKruvGnXEzbiyzeFM5mUUr4zeAJBjGR6A20K+5oLSQYMycumqGug9AZmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=B/mD8xqUtuS1X/1BVvAUAYNhqf5YduJDI4/XoYdIVPw=; b=aoNfFCM0HdKity2TiDTcuIvm9p
 Xy4/elsatcy3jpsfBQZohm3T22DTNHC6CynI0yVrmRwpOV8jxLRgRjO+fno1st1/tOFZLFD8Gu89p
 2okLw2fFXjWkTJmqcI24Mr71Jg5hskjL7JKWiXyE4zIi0iv0FHpuSJENt/3JUOeIfZo4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPNAg-0000a4-Bf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 12:34:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B6C2261374
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 12:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B5EC433D2;
 Tue,  7 Feb 2023 12:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675773237;
 bh=2A+v00E/A5dpsEKEfw2OcVL+bOiHBsj6hDIsDW20lls=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=REGS7aEJMbtjGFiuV/HI9Ck9yJ7idTNro6qCM6sveZJgMQ8g4HnCfWdClT7J9KJZK
 LionPS3plQmAEkZsVmC0G9fgvqsgG8lB8Iv3Xap+FqY9SWM/ZvXLc5bZBLYLshsZho
 U4doqHqtXZaghxncasQEtWBoJnmBYlgXPx3Apf5+Uublee4BJmpziEbnbKC+2Z1POf
 14ssP963lK9ziUnG/F9ghjhzMPVpJYMJlErI5+J9f19bJWfAqNM15Q3xk4hybxfEF0
 FwWft2GkCnMynUEdRApacNg/lqdyrZeowypJYHdmBCv5Y9jltZZfUgy8Ezeby3gNXA
 fVgSsBMt852zw==
Message-ID: <7b84a05a-c0ab-2d85-8052-baa6caae89b5@kernel.org>
Date: Tue, 7 Feb 2023 20:33:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20230206034234.723684-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230206034234.723684-1-jaegeuk@kernel.org>
X-Headers-End: 1pPNAg-0000a4-Bf
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: Remove deprecated f2fstat
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

On 2023/2/6 11:42, Jaegeuk Kim wrote:
> Let's remove this.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
