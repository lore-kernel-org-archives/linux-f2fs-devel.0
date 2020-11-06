Return-Path: <SRS0=5IuM=EM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8DDC2D0A3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:39:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D2E2151B;
	Fri,  6 Nov 2020 17:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Fyh6iwgp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="O9biP3hs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="L63lbg2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D2E2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kb5iE-0001pe-4u; Fri, 06 Nov 2020 17:39:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <josef@toxicpanda.com>) id 1kb5iC-0001pX-VR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Nov 2020 17:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=; b=Fyh6iwgpbP3JtORZww3laDBGc4
 +b6ZK6XFaauMhqlq3usIl/vxVmtDeE8cVwa5nWrvfz3EhHkeWg1SJGMaeft3kafsnQ+9oQdPrECD3
 cdSvEq4TUly0JbX/0ctJnkeDRydX/DljmxHxCYKAoIusER2mOE0LcRUKFTU14Ue7Rb/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=; b=O9biP3hsYEGtpV/ao7J9RuRHg2
 L6kKrp+ebi53g9/NYjWVVDMYpxLvV4dfTiJVWJc8VaDHrJkOXi2Qg1N+6HjrIx/zrHOenOFTz1Fhh
 zO+YHHzrM6fMqSFV15KXzZ5S9aHgtBokVdQMgdw9z/4uf/VIXQft2QuS+2mH86YslvAc=;
Received: from mail-vk1-f195.google.com ([209.85.221.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kb5i7-00BnlE-K2
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Nov 2020 17:39:44 +0000
Received: by mail-vk1-f195.google.com with SMTP id q77so418529vkq.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2020 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=;
 b=L63lbg2QmniDGJd5a4dxIrAFndNycIdwZhwtxYs+Qxv7y5+4iN6IKBL80tLuQ8W+ML
 8u0wO9MMvdmY0nZkdoO4X4PhNpnlmGn/jmuN5i0zBP41zIiuLPdN2qYWkoP8fwvUEdr8
 i3asb9BAg8ipiJPc5IdL8RfO3v4YzJIs0OOtUEvGvVOYKtHkAKMyj5B+rfHHYlbdRKhy
 hU7hN/sbEQw1EqDBD9c5duJHpeoPY1EnAZRbwbDgVk3DuXXBlTbwAEXtWhlVj+UheA9q
 iMn5NdRk+MyS6zFBsGNx6Gkd6a/cBIp/gTYZtLAgZrlzIdJoAhUMboc4TSdoZw5slaBM
 hmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ANXxIZx8OahFtF4xzwzNX4YdqVaHg2s+5GptZte/gOE=;
 b=rcYTNZJ6c/V7M+MQDxQC2p375sQnyTXsbGdqUrH5kHG6kCtzbs4m8WRJMjUc3I+dBe
 9HOAO1FQSp24wTLVoV9Ck4hq/Mzxe5qn5nuBX7WoSQXnACOK6u+UusZRF211RxuU7LKs
 g9IBjCAQ2xlf7+HkZenEKUGLnlusRUqttgt3yIuXGQ6NYalPe6i5RfY0QQGtNRqZ4KCA
 TO54Iy3ToW1y/6e3N30axhp/6WdPvL6AxM6rWYGyDFj59dMkDrqweqFD5+fqtZpUfFVE
 2SCS861br4O+EY4FuO9Dgrx7LreW0Qf5eNrmiJ95osYBdvE49XKlrtfn1HkzfiA30OSh
 JkUw==
X-Gm-Message-State: AOAM5330bzbwB/GbO5bOxwraAjDNvRb3R3VT0DAZ3lFOByXcF/4LpDlU
 eyJ1E4yz9qwetCiTO+zVOTn8O/kS+DetUe3CAhA=
X-Google-Smtp-Source: ABdhPJyN/9SAhQ9aRdjQ+lvSquSge3ay9Lrb+110kCzcwVvPbLGoYFikdNP97xpth1ZeP4uZJiI83Q==
X-Received: by 2002:a0c:9b91:: with SMTP id o17mr2367164qve.8.1604682938171;
 Fri, 06 Nov 2020 09:15:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com.
 [174.109.172.136])
 by smtp.gmail.com with ESMTPSA id x31sm932075qtb.81.2020.11.06.09.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:15:37 -0800 (PST)
To: Nick Terrell <nickrterrell@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Message-ID: <025719a2-2432-8204-201f-adbbd293fa9a@toxicpanda.com>
Date: Fri, 6 Nov 2020 12:15:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
Content-Language: en-US
X-Headers-End: 1kb5i7-00BnlE-K2
Subject: Re: [f2fs-dev] [GIT PULL][PATCH v5 0/9] Update to zstd-1.4.6
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
Cc: squashfs-devel@lists.sourceforge.net, Johannes Weiner <jweiner@fb.com>,
 Yann Collet <cyan@fb.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
 Chris Mason <clm@fb.com>, Nick Terrell <terrelln@fb.com>,
 linux-crypto@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
 Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/3/20 1:05 AM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>    git@github.com:terrelln/linux.git tags/v5-zstd-1.4.6
> 
> to get these changes. Alternatively the patchset is included.
> 

Where did we come down on the code formatting question?  Personally I'm of the 
mind that as long as the consumers themselves adhere to the proper coding style 
I'm fine not maintaining the code style as long as we get the benefit of easily 
syncing in code from the upstream project.  Thanks,

Josef


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
