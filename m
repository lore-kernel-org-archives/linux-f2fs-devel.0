Return-Path: <SRS0=hpJI=7Y=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F98C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:55:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71FE20823
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NbRwHjro";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JRlA6cuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71FE20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jjJvp-00027V-4e; Thu, 11 Jun 2020 09:55:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <mstsxfx@gmail.com>) id 1jjJvn-000278-Hp
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jun 2020 09:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OGc4Jynhv8J9+LXwEVD2pmhTRYA7A0SBRA8Y9bWfwBM=; b=NbRwHjro5uKKGxj1pa/HWs3Rpw
 N/Ti2SvefUjfAR4cc7Wxo9KekABOlUUvrfXUnkrU+wbHQBbTizuIUPhDOi2PduCAPlVSUeKm9exyA
 Qyf1BrG9sLXxV+fMMyQaA3Rj2b+tnHDFcmowoemo6+umQ4Feto3cmWoj5CrOxnUBaNu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OGc4Jynhv8J9+LXwEVD2pmhTRYA7A0SBRA8Y9bWfwBM=; b=JRlA6cuTJ5/7XsizC/DIRvnLDY
 FaasgBO4feiDDZORnKFxgo782s7XRgtWJqL/xLNYqe45ahPSj+MJqctElA+uKd3RkAZ3XetVhip1J
 LanQYa+3iHi0bxCzXkLBSxEa+Qf5yLzFe0g7Y4exPoMfCvK85hQK+jEmJIBUK9l/tEVk=;
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jjJvm-00GXJu-BU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jun 2020 09:55:31 +0000
Received: by mail-wm1-f67.google.com with SMTP id u13so4398136wml.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 11 Jun 2020 02:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OGc4Jynhv8J9+LXwEVD2pmhTRYA7A0SBRA8Y9bWfwBM=;
 b=YTScPerOe4oWEQwlptPzjwvTX3MsySX1D/ylIgGxMslhfADPu4JqQqZXkaezM9EniA
 W/xHShb6rIAtaVPSDyFLvLzdlgqtk0IiFgRUPfQYJqDbyECoAlQFmTKOuYJky/CjrMyS
 KbgX2l01g72ZWdxaEuSsu0eHoCFKbcmtp2JvzJ6shTD3CoIfF0XM4zgokrwuxndmLvsM
 +4xLbWzp2PYaiiPYFBYSNnr5g7nEVOoZa+lAZxJl4kkfVpaObVu/eNJazRPNDgU9SCGg
 fq/5WYbunTwhBO/VkVF+KXvFqxsEsk94rv6OVBZNCvAB9jXRykSS5LeSuK+p1whVSigQ
 mALA==
X-Gm-Message-State: AOAM531E186QlSzvryC1AfVEugMfTh8s+nxuKwpJECfeoClX4syo2YDW
 XsEzpNzwR7gRonvo3d4/tpE=
X-Google-Smtp-Source: ABdhPJxdFlFuIOqczVMYLEkBB/5DcRTZD3uW4Gi3wzWe6yykRWLuYTOprRKGwBQhCme4nouL4V90Cw==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr7719246wmi.73.1591869316876; 
 Thu, 11 Jun 2020 02:55:16 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
 by smtp.gmail.com with ESMTPSA id 67sm4301281wrk.49.2020.06.11.02.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:55:15 -0700 (PDT)
Date: Thu, 11 Jun 2020 11:55:14 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Chris Down <chris@chrisdown.name>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20200611095514.GD20450@dhcp22.suse.cz>
References: <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
 <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
 <20200529015644.GA84588@chrisdown.name>
 <20200529094910.GH4406@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200529094910.GH4406@dhcp22.suse.cz>
X-Headers-End: 1jjJvm-00GXJu-BU
Subject: Re: [f2fs-dev] mm: mkfs.ext4 invoked oom-killer on i386 -
 pagecache_get_page
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
Cc: lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Yafang Shao <laoar.shao@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block <linux-block@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri 29-05-20 11:49:20, Michal Hocko wrote:
> On Fri 29-05-20 02:56:44, Chris Down wrote:
> > Yafang Shao writes:
> > > Look at this patch[1] carefully you will find that it introduces the
> > > same issue that I tried to fix in another patch [2]. Even more sad is
> > > these two patches are in the same patchset. Although this issue isn't
> > > related with the issue found by Naresh, we have to ask ourselves why
> > > we always make the same mistake ?
> > > One possible answer is that we always forget the lifecyle of
> > > memory.emin before we read it. memory.emin doesn't have the same
> > > lifecycle with the memcg, while it really has the same lifecyle with
> > > the reclaimer. IOW, once a reclaimer begins the protetion value should
> > > be set to 0, and after we traversal the memcg tree we calculate a
> > > protection value for this reclaimer, finnaly it disapears after the
> > > reclaimer stops. That is why I highly suggest to add an new protection
> > > member in scan_control before.
> > 
> > I agree with you that the e{min,low} lifecycle is confusing for everyone --
> > the only thing I've not seen confirmation of is any confirmed correlation
> > with the i386 oom killer issue. If you've validated that, I'd like to see
> > the data :-)
> 
> Agreed. Even if e{low,min} might still have some rough edges I am
> completely puzzled how we could end up oom if none of the protection
> path triggers which the additional debugging should confirm. Maybe my
> debugging patch is incomplete or used incorrectly (maybe it would be
> esier to use printk rather than trace_printk?).

It would be really great if we could move forward. While the fix (which
has been dropped from mmotm) is not super urgent I would really like to
understand how it could hit the observed behavior. Can we double check
that the debugging patch really doesn't trigger (e.g.
s@trace_printk@printk in the first step)? I have checked it again but
do not see any potential code path which would be affected by the patch
yet not trigger any output. But another pair of eyes would be really
great.
-- 
Michal Hocko
SUSE Labs


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
