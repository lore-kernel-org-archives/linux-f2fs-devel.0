Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478B6C7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  2 Apr 2023 03:16:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pioD1-0008Ul-P2;
	Sun, 02 Apr 2023 03:16:48 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pioCz-0008Ue-KO
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Apr 2023 03:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=it9i7riRn4hUTrjC7JuGovjns16iEfeGSbDXZ5SrGoo=; b=E5Nwh6jZV/yazY5stsux/L78W0
 bKcrqhHpx3AgzqhyNfvB1/5ovRa6rDzObGplZuDgA2DNLi08EoC2FoMvjFac2Ubk7WCIzd+GIBIIJ
 u18bkhAt97lBZpd0xwaKT9GISm75JsnVi14v9DP9cSPjFPTuNApGMCyTinNatSP7WA+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=it9i7riRn4hUTrjC7JuGovjns16iEfeGSbDXZ5SrGoo=; b=d60t5sbbH0sgByRDb55mkHKTyH
 E002RXwAockw1VlEI5/2+lGxGYJ0HV1mY2R1z0Lg244sNIRe6PCoSOlNEBU/ryWiMOqJYe32uAqeX
 a2VQFC7Y70BAZlM+DzY+FqIoeDaG+JA3yCo4zBQ2EWPYN2SNsPnzTf0DBdxWijAN0kzk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pioCy-0007xM-6T for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Apr 2023 03:16:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 890DB60A51;
 Sun,  2 Apr 2023 03:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E289C433D2;
 Sun,  2 Apr 2023 03:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680405394;
 bh=qTfnW+hzUh0eokuwDPYcMC56YPJnM7DJQY7FXrup0kc=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=mYpRaUWp+vWs72+6eTZ4LS9+AE68dgqikTQhVbo8EzInQAXjS0MeQU3E/A9qYh+hY
 26RY4GbvkgjRqZPCfG2glURFROv4V8S3RKu+wFTmp9gZk/Kx6W5Mc+dgpz0DuD0K1/
 jzz7WHqMyyVs0Dr5eJcdbnbsWQcJmQrzN4c++mgdNwV9UudEcIbjdFJxedEJvwutqu
 1Wkgz+Dcj0icmieG4lsUX5MRRtYH6QX3DZPv46LQiNpcqsozJsinYBynx2D1tuCPjI
 Rjm5ekZE2XBbT1ECVfFDzOT/IjWGSkuMf9zeqfqTcw4GadOvJTUNRf4O2Fvqgw/Vcj
 AJ3sxDHyAvyzg==
Message-ID: <e896c7ba-defe-6448-5bf2-e7c6c952970d@kernel.org>
Date: Sun, 2 Apr 2023 11:16:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Yangtao Li <frank.li@vivo.com>
References: <20230223073222.81702-1-frank.li@vivo.com>
 <ZAZUHQz1GIpPG4jf@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZAZUHQz1GIpPG4jf@google.com>
X-Headers-End: 1pioCy-0007xM-6T
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check quota inums
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/7 4:59, Jaegeuk Kim wrote:
> On 02/23, Yangtao Li wrote:
>> +static inline bool f2fs_check_quota_inum(int type, unsigned long qf_inum)
>> +{
>> +	switch (type) {
>> +	case USRQUOTA:
>> +		return qf_inum == 4;
>> +	case GRPQUOTA:
>> +		return qf_inum == 5;
>> +	case PRJQUOTA:
>> +		return qf_inum == 6;
> 
> I don't want to make this dependency of the inode numbers.

Actually, mkfs.f2fs allocates qf_inum dynamically, above sanity check
may fail mount()...

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
