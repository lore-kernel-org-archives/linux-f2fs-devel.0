Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843BCC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Nov 2022 15:39:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1optMk-000467-Ue;
	Tue, 01 Nov 2022 15:39:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1optMT-00045t-Gc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Nov 2022 15:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hlk9UOy/BX3buFo+iHpDS65qb5fC3EpeGTg6ClktIi0=; b=bIvTxCf+ir7vpof8nGcrNLevBe
 bev/xFf8OqPiY0pGge6a+oxDoaUI/KWFCqxcoezXnJhyUcrrDbH8UM1pydiEldxf8JomRXhr7mR0a
 k+JuFVbhDxtgk/CZTK8t8HbTI4JLEd0jEeyuGHsw7nPz76l5WVHfydmXrEK0+0Z7xM9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Hlk9UOy/BX3buFo+iHpDS65qb5fC3EpeGTg6ClktIi0=; b=FOEe2WCEbDAUPimtRrAF6GW5rY
 44lgaaZPNTit2GqMMgTNYGprO9AJXL/U67IMEq2UIAXVe4FgHTxn4o8VwZVTrlv5UHAotgx1D4T+z
 R/IfOhaUN/bS1UqsoykYbMXvlQ0j4/Z0hh+aljCvzqfKrcAIn15x6VQF7XgiySk7ZT1I=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1optML-008Eaq-3h for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Nov 2022 15:39:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AF31A61644
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Nov 2022 15:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814D7C433D6;
 Tue,  1 Nov 2022 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667317159;
 bh=65CZL2l1IBOmMGUelHQiR1wpkyHLMFLr7kZuNM7OCGE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=pUk9QZid7zs08/+OcIlt14B3aGnShZLGKET+sTGEI7U9P0jO4rnFZG1wIkgULUGbk
 R+yjtmEHm/roUpUgnxQ1GsyuRM2wRZnGP+Rz/33f3AGCVEL9G7gyq5q2pAsqDouHT+
 ZMhjM72Nc3OoC3m/6K21uJJyiaz0VbqVirHYBfHqicsFKe2FTtWVtCFq9KOIEM35cX
 4S07QuKnNO+7QfwMujpV8UW5V3AxIBV6PCZ9aPztAYgjYJu8manD7Qnw6uQwIU3X25
 xHUeaRe/NmhCe9ZR4dEE4drjram1n1zua00M4Ffj540cC8Rdc+6xV8OJ1lJXjU0zvk
 PoxcpYZbYlCyA==
Message-ID: <e4ae8a72-3e29-637f-2cbb-0e81020da1d5@kernel.org>
Date: Tue, 1 Nov 2022 23:39:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20221028165827.11558-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221028165827.11558-1-jaegeuk@kernel.org>
X-Headers-End: 1optML-008Eaq-3h
Subject: Re: [f2fs-dev] [PATCH] f2fs: use sysfs_emit instead of sprintf
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

On 2022/10/29 0:58, Jaegeuk Kim wrote:
> Let's use sysfs_emit.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
