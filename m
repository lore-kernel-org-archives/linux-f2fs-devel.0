Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B2CC7EE2F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jun 2023 01:52:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8tCp-0001xw-AK;
	Tue, 13 Jun 2023 01:52:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q8tCn-0001xp-Vn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 01:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=; b=De5xLv8UiUfU4d0aJxuXmMhqpl
 8gkwOxepuZjmTi21DWl2ACfBolTWUQGl8SMO3+icT95x4HyvNeoNP/SOAXcZU8+4RoEQbTXMdpx9N
 xg5J38mee/mml1fqJk5Y0aveq6CXlOmH/Pa0xm6OxjqEx4s/25AaXACVJRt58newGep0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=; b=S83PdmiMfAVlX7j8cRH7gLybV/
 olKuCv/hojHLIIPLiGXdZiEBJT/37FYndrXuHq7Ds0jiVbLIAAwp4D0yK9djTa4X6vEAQ9WvTLOTt
 1BE6Le/u1hXRbC7cVlvzW9kiu31itNdCET+0GsO9t98yxCrzS0VLOyTK3EjitaE26ym8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8tCo-0008KM-Ab for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 01:52:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E88E76305A;
 Tue, 13 Jun 2023 01:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3444DC433EF;
 Tue, 13 Jun 2023 01:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686621136;
 bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q9ljurLQy5R/F040JQA3pUPEN3VOulN7aVTGlIXAvs27kNkZdSLIvxq2HTDo6eOoy
 w37s8Uk9+9KeyqG/EkXtifnZiphSigiBy9i2hVs1e3iMkJppdD/Vt6rySor/b9Zd4l
 BxXwt4BTY2gdzdsh5hnmZ+6fwK2zgHoI//fLRvb17dkF/XsQW5tzTP0k5xlz8rRqll
 Rj7cDJPYVmCvXpp2tbe6YFP9XXRpKRrAkQZNTlwaOwS4y/FztpciwCGBgeh+Rcc+h5
 g23SW2+VkUWwJmViu665/vSB6JxsjrNwnPrVeSSCwnxMTvaA9G1KVYrhs/9wsbn+fL
 ViNs4pJoBOTxQ==
Message-ID: <974680a9-ffcb-1290-80a6-c4791ec988c0@kernel.org>
Date: Tue, 13 Jun 2023 09:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-4-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230612030121.2393541-4-shengyong@oppo.com>
X-Headers-End: 1q8tCo-0008KM-Ab
Subject: Re: [f2fs-dev] [PATCH v4 3/6] f2fs: add helper to get inode chksum
 from inode page
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
Cc: ebiggers@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/12 11:01, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
