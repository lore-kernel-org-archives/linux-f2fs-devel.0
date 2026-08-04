Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA29C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUA5lNr9x3W5yY3EEKVKunvCmJ5RzCLUTZ4/VV/H0zI=; b=HKMRe+nynkNt4g9l3qlQ0Zc2IU
	UQyqOWXKY0taFi7ZuMxph6noSAp8VkcwSM50zWbBU3bgS2chGYlKyuUn943hpJntAkZ9wYGW7gJGv
	WnfmTsRceER2lQQundif91c89mq6TNkfojJn+cUE4G3M20kPkiF2+g3/Xhn6zruSCigY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2fA-0006iN-3p;
	Tue, 04 Aug 2026 00:05:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr2f0-0006i6-AX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8m59mUgknIzFNE3KkNv73wHbJUz2b2//TAvB9H0t7s=; b=V52Rb9cNBRLrNy2mBsCf/SWdw4
 obLX9p6/ZA8jAEwFzl3konDmVrnPgfifpVvapIhZz7N5IamNTmhSi099HsXt/fEccQjBXRoJWbrnE
 VC7gBCiWln7+3MXV8E1ibEUQtZO5R3Oeyww9h8tadgWnmgMJMOxc0vRD0Dnewc061x3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m8m59mUgknIzFNE3KkNv73wHbJUz2b2//TAvB9H0t7s=; b=gdlCp940M3bgczNDZaMU3rcqqQ
 li26GfUvktYHOmzvs0G9TME8INOovB8UWVtKmzPK/dXqcRE6bIjkkep29dTkyQGwPM8TS8/SXRlQS
 mytVUSHFsxMogr1osG2yar0xCX1qUNUtD2hpB9SfWNFY4fSEcJNVM8tOug9bAvr/zTXA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2ew-0001uZ-59 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:05:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79B7142DB5;
 Tue,  4 Aug 2026 00:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAA71F00A3A;
 Tue,  4 Aug 2026 00:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785801924;
 bh=m8m59mUgknIzFNE3KkNv73wHbJUz2b2//TAvB9H0t7s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TWNOXS08YoHCqy4TocKGm8XM4hhbboVRW0mYztiuNDmBuxGxJK/twtmoHGBOZNSKV
 fQVky42Nwc+a8mt9X2NYYO5IIryvFe2kR1fhq1qDkZ26/AhJclH+WXMzMQVS2q4YSH
 HJ+iSNkPq2aPMTGelVEqfzjW6h6+haeKQb4vys902nnXlFT2HgWzaEsQWImoGpTtYi
 mofUqkVJBXQQbi2tOAG+Wfz126+RAM+g5FNKJLfmKwxis+Hrv5ULH30jyRUHwkf5WE
 aDN/5Nqbg7G114axXKh9VJRbjbpMjqpm+Pu+vW5GGJxy1I9g0FeRXQc6lXnvDHbXLY
 FFZdXtuM8Vg8Q==
Message-ID: <26d898d7-8be3-435e-ba96-9d12dc549d38@kernel.org>
Date: Tue, 4 Aug 2026 08:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <4493e1b9c502f9394cb6522ea433f43a64f218da.1785775861.git.bvanassche@acm.org>
X-Headers-End: 1wr2ew-0001uZ-59
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Run f2fs_write_end_io()
 asynchronously
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/4/26 00:52, Bart Van Assche wrote:
> The bio_for_each_segment_all() loop can take more than 10 ms for a large
> bio on an ARM little core. This is too much for interrupt context. Hence
> perform the write bio completion work asynchronously if a bio is large and
> if f2fs_write_end_io() is called from atomic context. This patch reduces
> the time spent in f2fs_write_end_io() from about 10 ms to about 150
> microseconds on an Arm Cortex-A520 core if the max_atc_write_bio_size
> parameter is changed to 16384.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
