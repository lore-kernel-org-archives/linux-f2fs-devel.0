Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE8DC56208
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPpGVkYMJmOQY8boMv6RzhAlUigQqgxUaPLM8WPKd8g=; b=BtYJunH0v2VEQfFuq8g7iXuG3m
	s9mpNZR2sx2vh18qQ7DkSsMDs45QuC1t/Q56iAd91jUrbbx7F+1a0EnrKkU20eB8gUA2xO5c4OKs5
	UAxv9ZXFg4FsaKTkvr9uRw3GiFec7oHT8m0uRXT+j1rgAavalPtOWg8qMRB0v+2Gczws=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wry3x-0002Bq-Lf;
	Thu, 06 Aug 2026 13:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wry3v-0002Bb-QE
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:23:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w/UqedhV5wxmUnfZTQdqZBX2ih9yOYB9Lp64bc4xoVU=; b=XaOTmRcY7D9Ultvw83fWMOX+Dd
 xKYnevnET8fFbbRztBRvENPo+CSYdU2KaMlhdXaRt9zWy1XfLI+MvzWmW5LQoAfeZcqz5z1VNS64L
 F+haIyc5ImVQPx37U6+SBU/GDdvPo0KBmzwg70jm5s9Kyw1G2Gd8atHS+VQeXVRvJFF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w/UqedhV5wxmUnfZTQdqZBX2ih9yOYB9Lp64bc4xoVU=; b=hwDR0J5z4TeyiTrJPbN991zssO
 Pvk+i59rGJl+BbKkORBxILptY6+62tGHEvc0jlleuBNr+Q+99fKPOLoh6wvc6+cQvgJnSBPCKOCQA
 44FjCW80C/Werk8klDuZ3zjiwuTbFdSvSNNMZi+E5mVtZFIarrySH76twSTX7/H4+isA=;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wry3v-0001uE-7T for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:23:08 +0000
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso2646455b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786022581; x=1786627381; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w/UqedhV5wxmUnfZTQdqZBX2ih9yOYB9Lp64bc4xoVU=;
 b=DXY3K5kZ5Tjvmhd9sxfEusQzRYiNgfz6PzjTLAIwVR0ssvGZ07+jQm7+JCTZic7NVt
 OMP6RUSYEBWgkZIbdn1G8qxkUt8dOLosufi/PJnEkyN348GynaGsxXgMhb74si60cKxg
 OFZvudGaOiNSOuoZH0uxsz34NO3JBXzfUdsjQElg0EiGbaCxqT/4Jz+ureqqhNbpNCL3
 bZz758eWJYU4a1fRgZf21kr5lA0IAaweSqiKls2+9uu3gtUisUd7Pfo0d/4TLs8CAoMd
 Xu6+cT59/9RcEAYmbQ6z7BLd8bnOc3eHtbBbNks9Kz+pYN3OGoZQEndKPSZf9tlS4r5u
 IqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022581; x=1786627381;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/UqedhV5wxmUnfZTQdqZBX2ih9yOYB9Lp64bc4xoVU=;
 b=DMRUizsSKzg+0OHKC4xOjufLMnV7kUunnra0Q9YP8z9TszytpRUX6iX4g2sPdv2cdh
 mwUBo+IS9V6jDoniv8ab4qjQxYt5FwY9U7kCqjF8AkIKsFgUg6XVdjlo8L+VybQO8D3E
 XbXcci8BLaABD9YJ1EeEdAo6sXGmLWi3+myXqUOijg7MzhuIgr+VWdgrK7XCK22STVCD
 +0T0jgNoWJPM+T3h1sVUu5yZ+gsEIpdrr5CmFduMreQ7z1LRBWBviSLfDwCu7vTO0dUD
 Xz4z+sNx9HAIQQ12FCqiAlBpQlT84zcwP5ZdLiHI4pR2jApn83beQepsGOiaHP05qkvx
 W8dA==
X-Forwarded-Encrypted: i=1;
 AHgh+RovgV02KgTErT3qRoao63esIdAYq1RykBVHtvhKP9H0QVR8s3VNfZJDrebue/4tAOOcfEM3kon4LOqMheIhd3NG@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz2EfRgrqTC9lPW8egMk3fUPUYfTQQ1K+CUbgH0OsvvHH0kvD9B
 Hb+R9VCFeDx40zRxtzHlb+nqasi75uHDZD8+BfiCPWnIGc/XXOy9K46o
X-Gm-Gg: AR+sD11oi+ceYJuCD2wH9BJwPdhIN33k+7VFOiO4Uv//31HV6wRZrhrLQvSgq3vc+4x
 UENpUv1F5W+/F9x/5mNWLL5bpBh8y9rW6UUof8nYNNqgh58qAmZ0DuBJehcOCr9soc0yKxwnf8R
 aU6Y5ap/Sz5p42oalRD/Xb3fymT/AMutwY2mlsdK8NHg3FLlhFNDYoCReXweSZ6AMJwEYBxLAKC
 W2w3Wc7QL3/uDc0MC0vzB6JJ+V+hqPlUZiJZPcTTtSFyGXCrfF7faSTRZi92GS2Mr26ItkS6TNl
 Dk9HTnrM/whfcwh78Ru+b6f+6mmr510cMAq4BWz97FAkQq07U7XCpwlHJrbWqr2fxj63Qq4ZYbC
 NoTkE9LHgxp+ZzpzgXSGj84NtD+8lBeBdCiN5jS47C+7jWX07o/I73kiayHYEn9kVG6506kIADB
 eGk03xRFapzqRhd/rrZ8yZtBTgNXCl18zg1Y9jVPAaz3zZLBzBxk4hfWEC4BpPrF3FOXxpBumBg
 k1EhFCG5GTnSME0gA==
X-Received: by 2002:a05:6a00:298e:b0:845:dffa:3740 with SMTP id
 d2e1a72fcca58-84f2e0151aemr17945524b3a.4.1786022581450; 
 Thu, 06 Aug 2026 06:23:01 -0700 (PDT)
Received: from [10.189.138.37] ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45bc9c1esm1430205b3a.55.2026.08.06.06.22.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 06:22:59 -0700 (PDT)
Message-ID: <cec45733-552c-4bbc-b133-fd090e629900@gmail.com>
Date: Thu, 6 Aug 2026 21:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Yongpeng Yang
 <yangyongpeng.storage@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260724125847.3928772-2-yangyongpeng.storage@gmail.com>
 <20260724125847.3928772-4-yangyongpeng.storage@gmail.com>
 <022b437d-b1c9-4f62-aefc-a6d32ee6dbe3@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <022b437d-b1c9-4f62-aefc-a6d32ee6dbe3@kernel.org>
X-Headers-End: 1wry3v-0001uE-7T
Subject: Re: [f2fs-dev] [RFC PATCH v3 1/3] f2fs: introduce inline extent
 mapping for inode data blocks
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/29/26 20:19, Chao Yu via Linux-f2fs-devel wrote:
> On 7/24/26 20:58, Yongpeng Yang wrote:
>>  fs/f2fs/Kconfig         |  18 +
>>  fs/f2fs/Makefile        |   1 +
>>  fs/f2fs/data.c          | 148 ++++++++-
>>  fs/f2fs/dir.c           |   1 +
>>  fs/f2fs/f2fs.h          |  44 ++-
>>  fs/f2fs/file.c          |   1 +
>>  fs/f2fs/iextent.c       | 712 ++++++++++++++++++++++++++++++++++++++++
>>  fs/f2fs/iextent.h       | 163 +++++++++
> 
> Hmmm, the code size is still a problem, too complicated to support all
> insertion, deletion, merging and splitting operations on inline extents.

I simplify inline extent update implementation in v4. Please review this
series:

https://lore.kernel.org/all/20260806131906.2961409-2-yangyongpeng.storage@gmail.com/

Thanks,
Yongpeng
> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
