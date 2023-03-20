Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9BDC7618A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Mar 2023 04:24:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pe74b-0007th-RQ;
	Mon, 20 Mar 2023 04:24:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=436eb87b3=damien.lemoal@opensource.wdc.com>)
 id 1pe74a-0007tb-FK for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Mar 2023 04:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JYV7H64jfRymT5rzh2mlGslQT2jebjxqVf+uMCU2w2U=; b=HRrQEHttUhqQ/n+MCAQLmr8sWA
 YXBABphWBPIa6oMV1AcSyudhh5v/aSGpmbkXG5K1A9ZODJ8/ILg+VqqbogTaovDOLDlE3ClM9DDvf
 h4FRopOn5elud8pNq3NjTG6CXEzmWnKn0S/wpG0rFQFwtlJnszT7NzhtGlILJuHhdQOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JYV7H64jfRymT5rzh2mlGslQT2jebjxqVf+uMCU2w2U=; b=a7h663/YOG1q1M6BN6/aHHCcvS
 bVj1Q2iqKXqmdfREbUnHsXCu0LOysyP1QdN/WsLNm9/YicpzTFCGiUKQqPDYRgHt0YRBQgEq4DWyy
 SMowkCbTK/SWuL/FXAHNVcRBNYuHK7HNH/QdI1Uv7b6UQcNC/yvF+5E3R9UAOfHySV7A=;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pe74X-00DyPM-JD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Mar 2023 04:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1679286277; x=1710822277;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7Rb8kJGp8=;
 b=DWvwLBtshemOSh491Sqxd56Mm2BuCEaNALWpGckEwdh6fGjLQqrDM5st
 Sevz+qzYpJE/p/uJe+IFumY8roszNRHTSr9z4K4ioZjBKa7rfAV5PFI6O
 O7Ihni+xIVhG7EG2mNPLo5k24fy185NhIdzMMtFm7HLG3NvEUUiEielHG
 j3tAL1uZ52Mlq25tg5rooQ1W0i/BCZd1LDO1ue6lens+n3HAwVh2wYeCD
 pvzaXPw/rAvW0QZhqC4gmYAcfv8JVFHA6yGDBSbPGIeg12DnN28F0O38y
 Y8WRVQEKX0kCKbh+9fE2cEqcpg6mzTfSl3bOhyrIvKmDuR0H/CazNifH6 Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; d="scan'208";a="330416223"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 12:08:52 +0800
IronPort-SDR: Vr6lTK1gNFarcCQ/2bzxzuw+gvo4rxDPSKQQ6j19bRPqnrp15N3ywyRsZmmso6SE3VEGYv+2yT
 BRgAM5vaT7mtCwMrlXynwYW1tTaWPm6On2AXZM6ZC3ZgS+1dh+USm7VetOuNy+QsIjQB9nuk+D
 LpPEI1+IWJsKtOw1qORonBEOBTkc1w9zVyWlGhBvukxWPHi2Ou/sK0IBUIYUJiKkqiKbbrXXbk
 Rf6nD/ovuC9yZsjHzB02JtY0JtCM83syDWjFLjmzomUyXAcDyxuwhcayD21KZ50k7Gc7e5re7H
 ycg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Mar 2023 20:25:13 -0700
IronPort-SDR: olUZmWPkq2cuh0urgziDnmaHQ8iLPUUsGqIFl03yGVT5HO44MEDnYgCb9OOAUgDTR8y2YVtYZg
 NYoTLxbiTgpAGre8C6AMcqHotl8dTmBmhXiNbivw/O1IXMfnPWugQyzUzPlVGe2vhZy3ZUgPje
 zwc98+S4shYNSSqReWyBxDagce14MiWK48zpNuVgrm9947569jKa+XISxaBmJGqSr1HOJ1Rqcv
 yfylLnJ7p5pxZNn/QOl8ikrV2ONXGXygtcyjIK7DQudK7P0FQLDawGSaFJ0BZGad+I/sG1tpak
 //M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Mar 2023 21:08:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pg1Sh2ffxz1RtVp
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 Mar 2023 21:08:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1679285331; x=1681877332; bh=f0RzrlZk36B8QlnIxOLMByV1TWNDOIMn6+7
 Rb8kJGp8=; b=esT6TiIT+uoup3kWnY3xrSB3cYopIRmWLNhiVbZ6b5Myup6B95z
 p61YIXMydR7cv+BOtazS96fyHYNv37OnHrWVo6KCl4jC5ieFCwmxLpn12eg4/ysM
 pS91jjTlyfK5IAAj0Q5zaqAOyizcA9mGTXR4Q9eq3vYIamyUJ8etCo+vOy9sjk7l
 p6COnj+QZSprV+wuLiGHG6enDxDehZbJdOfQd1HClGCeQ2lGXZdLd/Qb+7pT/ebA
 Y3GEWaET42Y/8pV3BDj2JZueEuXtNYDsemmR9wfaJ23SwWvVQpUoQVjpDABRoBk6
 y7rjMU3wwH/4BD2261pJ4P51bH/Uqaj+DNg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026) with ESMTP id S0lWyR02WMS5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 Mar 2023 21:08:51 -0700 (PDT)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pg1SY32s6z1RtVm;
 Sun, 19 Mar 2023 21:08:45 -0700 (PDT)
Message-ID: <e4b8012d-32df-e054-4a2a-772fda228a6a@opensource.wdc.com>
Date: Mon, 20 Mar 2023 13:08:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, jaegeuk@kernel.org,
 trond.myklebust@hammerspace.com, anna@kernel.org, konishi.ryusuke@gmail.com,
 mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 richard@nod.at, djwong@kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 gregkh@linuxfoundation.org, rafael@kernel.org
References: <20230320033436.71982-1-frank.li@vivo.com>
Organization: Western Digital Research
In-Reply-To: <20230320033436.71982-1-frank.li@vivo.com>
X-Headers-End: 1pe74X-00DyPM-JD
Subject: Re: [f2fs-dev] [PATCH v2,
 RESEND 01/10] kobject: introduce kobject_del_and_put()
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/20/23 12:34, Yangtao Li wrote:
> Hi all,
> 
> Out of consideration for minimizing disruption, I did not send the
> patchset to everyone. However, it seems that my consideration was
> unnecessary, so I CC'd everyone on the first patch. If you would
> like to see the entire patchset, you can access it at this address.
> 
> https://lore.kernel.org/lkml/20230319092641.41917-1-frank.li@vivo.com/

Hard to comment on patches with this. It is only 10 patches. So send everything
please.

> 
> Thx,
> Yangtao

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
