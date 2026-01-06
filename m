Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053FFC47BCB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJu1F1In0zp7bpUlLIpVl9fna5apMlZ/9gphiyIXKz4=; b=DQaonweDUR0/WOMHaBKcL1/9D2
	O7ZPNp8e9LbYg3GrqRr2Xi3Khlb3HJkl/g+gE/JN6fo9Ym3zU1/3t2KRBWPvDMlc0+C1rsOf5FbRO
	TzOLECh6dXx2tqlxHnxC1G4drh+Z4doVgF1oS1fke/v86AOgdMZyrvOWGqg0lySDh1sQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vd2qp-0001Fr-MM;
	Tue, 06 Jan 2026 08:55:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vd2qn-0001Fk-Rn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 08:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cl2FvpAl+Ww0b3mXGykMM2wWSrAEp+KN61Kr5gKmj2U=; b=eww55ghmYdLFlt4hcqaThRIWJM
 D1fokFYVFKJSSYFoxpjL6RzPsSyYrTlH1wPJgl0BHO7TVR7FcvprYLk60MclnAJuOEBN8N+Bc6pvR
 KuwDJNSVYAggihpnHkny5yfNPKTFnAUrukg2lk5k4TrJAvX45sFMNG5gHA1zZezhhPio=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cl2FvpAl+Ww0b3mXGykMM2wWSrAEp+KN61Kr5gKmj2U=; b=CggSVSVfkXqU1iDBdclnkV4J3r
 kCzC1XKtjg5K1eA7+4vB+A5yMuOB/8cUTONtaKH31wG4PPesEVkKPPzQg1FEfwRp9exXhUpnwCo/i
 HPbCK6gXGWcZnTkkd+G4XMDU8KqPWF7V4ZWRd2QK04obEougBRA57OzhaaM9oSWKwWA0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vd2qn-0000QE-A9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 08:55:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F037A4018E;
 Tue,  6 Jan 2026 08:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D182DC116C6;
 Tue,  6 Jan 2026 08:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767689726;
 bh=ZDcYXcwUL+cOOIWhQCtVxZWnZhaC9uyfctSLSAb7h14=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=tFhS9+0ckG6+SmjBw/Ozwhc7dFo+Ys8Bj7k/RsT3Jdkn6UNe8CpvNPlzNulgCbltz
 pSS6cRhTPIZcbR15MfREgqB109YJrXVRXots35fr4RbsvkEKIN8EEhv2qgrhaYKRSD
 CyTR9qPhXNpVKGkxTBTGrMHqqUR+pTP81vBQA4CfGMRubP0ajMEjHz6szHOTqGbvVo
 +D18aQ349R64ox78g35CsLEDhgEGoj9qBZ8jV4HifETEGCNNKiWbctTehI+Xl64BoX
 gKNmIlQ3Xe3g+ONhavwqRW3odOlqgnQd0yI04TYNTV0xvCAZvkWt0VWNQXooQT5kct
 S/VqjDYWK94HA==
Message-ID: <108a86aa-8f89-4a0a-9ade-d0d043997557@kernel.org>
Date: Tue, 6 Jan 2026 16:55:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20251231135433.1069590-2-monty.pavel.devel@gmail.com>
 <20251231165200.6028-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20251231165200.6028-2-monty_pavel@sina.com>
X-Headers-End: 1vd2qn-0000QE-A9
Subject: Re: [f2fs-dev] [PATCH RESEND 2/2] f2fs: change seq_file_ra_mul and
 max_io_bytes to unsigned int
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/1/2026 12:52 AM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> {struct file_ra_state}->ra_pages and {struct bio}->bi_iter.bi_size is
> defined as unsigned int, so values of seq_file_ra_mul and max_io_bytes
> exceeding UINT_MAX are meaningless.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
