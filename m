Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0C3C7EE24
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 02:40:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pz75Z-0004gQ-Hs;
	Wed, 17 May 2023 02:40:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pz75W-0004gJ-1X
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 02:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+UGL8REk3T2oLZSds1bwFk4w7dg+trb+BTfpGRQNXew=; b=TCFa9RLxOShc2WGffswjhksHav
 q3kboHSkbxWjneSnrMFDRZ/SqVz/DmEdWW2q2hV6UELLSXJcb3RgbRYsBU+7l4rEnEf5qDtY8KCK0
 VOdkTLetMJXJk0fh0JI585D2F5WVDdS4A4H2xfrTUTCOK9JyFtOLljMNtCs2KokCeT6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+UGL8REk3T2oLZSds1bwFk4w7dg+trb+BTfpGRQNXew=; b=dwMXYN9sS8OQdDiYnS3P8tUi93
 niVbyJNmwaEG2skA/Jo+zd4XDXMC91TGBkMLvSfS8ACpCjIgzvt3N12Z99e7wkaB1RE+s+97/161E
 M0A+7mA5QV3nkb9pYM/BiiDxzYfA7ejEzkEQGL4oQeaNxmz0IeYSwecm8VrATjh1T2lI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pz75V-00024J-GF for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 02:40:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DF14061085;
 Wed, 17 May 2023 02:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2495C433EF;
 Wed, 17 May 2023 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684291216;
 bh=NdrwmnejHdoL348J6WmccW3ZdlHY3rSkgi/6/8J/jcc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=i8PH5HNXNqDJ4w+iqIxFtytlXJGS9XfvLYfHVXQG8mf6Xd4zUba616U2iUVpYnQK6
 h+VN2FU0ztxn/omhVl8Scc1WImm6E4BLmszILp8I52pfG3nYGM+7JvUAQxxs5UtdsM
 jEfvZDvF3qxSB6Bph8nWIsXrVMHoDaUTKFMVIdB+3Gv0yS2jC38pDD2k1eGpdE+0zI
 8WtNur9FAsMZAOKVtX3ItRsiIhvrJizJWhOows6raG2sli7QdfF7pEvyOj6qm7QmnB
 I39THNrhW6mUtcL9aVZUtzj3TostteHDfylp9WRgufK591ooBmADKBNgIb4A+5o4gK
 x0cj0tShqAMjg==
Message-ID: <a089749c-061a-f5b7-1d09-2fc0fce2f76a@kernel.org>
Date: Wed, 17 May 2023 10:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
 <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230512041610epcms2p506e7539079670524146ba6eeeb9dbd63@epcms2p5>
X-Headers-End: 1pz75V-00024J-GF
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: Fix over-estimating free section
 during FG GC
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
Cc: Seokhwan Kim <sukka.kim@samsung.com>, beomsu kim <beomsu7.kim@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/12 12:16, Yonggil Song wrote:
> There was a bug that finishing FG GC unconditionally because free sections
> are over-estimated after checkpoint in FG GC.
> This patch initializes sec_freed by every checkpoint in FG GC.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
