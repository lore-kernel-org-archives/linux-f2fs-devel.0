Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B8EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jun 2022 16:11:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o3gT0-00085t-NO; Tue, 21 Jun 2022 16:11:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <daeho43@gmail.com>) id 1o3gSn-00085W-TQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 16:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=; b=c+IvGlKt9R0p2J9SJGzATREru7
 u0/Upq8q2j0CSPodDIGR0TKhxJpNEqRLTHzpvEo097Rpddf+Q8880gCKsucVEyf9uRKL8Tmyr8IkV
 KUEPcC9sOggtLefBu7I5sLmETb0XbmRLH3Orkopu+3ycRtUWz/h15Ni03RgtOBJRtkHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=; b=ZrQo1mM26aeqO6SpNoAvgN+1NP
 YHGJnsQIlue7wy4M5A9tTmeGENGGWdkFU5Ybo+WrCq/IA1j4mMsjS2v37P7rxyr4CxkldooAvUHEm
 KMcEwJr3spMbRE8su7vzYLprgeMOm588ci1q9nTG3IbTUibhbNTD4jMdJzOB56KoDa90=;
Received: from mail-yb1-f180.google.com ([209.85.219.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o3gST-0003q8-Sz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Jun 2022 16:10:41 +0000
Received: by mail-yb1-f180.google.com with SMTP id t1so25281018ybd.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 21 Jun 2022 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=;
 b=J/SWUBYSO1uT8oN30UoSsUFLbBMwF1LdwJeSz7ZJajlGm6CfvEEn8+sanhyyFTap73
 kvsJdepoWsBMC/WVi+BYzpT9h8sAVRRJMi020alPJgZSLJxrcvhGidhEgN8Luek65GpT
 +s2Qk23ok6Ur0Aojv1+1x4aO6I1GIP6SUzkYYNRu2shwAOkGcd46PJS+7gBNt7liXILV
 G0MS+nmwnoI4IkghITv48qE1c6vlLowScBNEP+gvIKeit4BDTXdQM1GUQkYfowDHoh3K
 npPCwAFqfW9DkVyWHl5kaIDZ4M9fZTEYPbXDg6LPG7xARxYheWJTS0b3b9UbsIB0buit
 brTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DaVXixvInX7Tije8Ym//sMBlj70LFPbdDShlLVQqFLs=;
 b=293E5UcpnaOpUiic8+uoXOUEUoflNU1weqEzVYS/j7kcfEdY6eQqpAYZJUOkz36cgm
 RhfOckapl850g3PTebFKEPRQNvQlYGBPJHCDaAyY2G045FrYJD+7LqtX0Ie4wofS9eL0
 VkWzaP8HeQyUEyRRqspwDK2YtT94MHZh8WkjxQqTCIvRt8rFCCb/JDgsqg2JZeTGKh+Y
 9y1WnBWt8te9hPx0A6PTfyWUd9w3/B62WQRHdJNNrst+qTekVIHcBCNSztPnXKNRSAs2
 C1FAyWmPVYmEb5tVl7F8aZahW8PuzsZMc6jeRVS1rqImtjKF7kbAMxie2uPgs/hbm9lj
 TKng==
X-Gm-Message-State: AJIora+LS1deQ2SlNbVAAki9/V0iemB6J1y8IUeZ6PIIYzw8POlu4vUN
 Uld4QzkepVQk/T3E+qPJPgkI1AeC3HIJ7Sy/wYk=
X-Google-Smtp-Source: AGRyM1vPTY5fnnYz8SMXMdXAFLn+4mX9lO6IqVjSY2QhCKA6LPbKcYS/X/8JwoA4JP55dvzx/XV4QYuV1HoFE7/Y7vk=
X-Received: by 2002:a25:b218:0:b0:664:6da5:b5c5 with SMTP id
 i24-20020a25b218000000b006646da5b5c5mr32419923ybj.6.1655827823953; Tue, 21
 Jun 2022 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220620173843.1462198-1-daeho43@gmail.com>
 <20220620173843.1462198-2-daeho43@gmail.com>
 <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
In-Reply-To: <YrEXmiRH+DcbW2EI@B-P7TQMD6M-0146.local>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 21 Jun 2022 09:10:13 -0700
Message-ID: <CACOAw_zBi_TnOmqLZwBF9Zdd=0m7EkRP9M210BOrabh3L=7bqQ@mail.gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Headers-End: 1o3gST-0003q8-Sz
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: handle decompress only post
 processing in softirq
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 20, 2022 at 5:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> On Mon, Jun 20, 2022 at 10:38:43AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Now decompression is being handled in workqueue and it makes read I/O
> > latency non-deterministic, because of the non-deterministic scheduling
> > nature of workqueues. So, I made it handled in softirq context only if
> > possible, not in low memory devices, since this modification will
> > maintain decompresion related memory a little longer.
> >
>
> Again, I don't think this method scalable.  Since you already handle
> all decompression algorithms in this way.  Laterly, I wonder if you'd
> like to handle all:
>  - decompression algorithms;
>  - verity algorithms;
>  - decrypt algorithms;
>
> in this way, regardless of slow decompression algorithms, that would be a
> long latency and CPU overhead of softirq context.  This is my last words
> on this, I will not talk anymore.
>
> Thanks,
> Gao Xiang

I understand what you're worried about. However, verity cannot be
inlined because of its nature triggering I/Os. Except that, other twos
are almost inducing overhead comparable to memcpy. Still, decrypt part
is done in a H/W way mostly these days, though.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
