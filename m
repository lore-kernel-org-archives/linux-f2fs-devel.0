Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764AC79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cNWx6Cof2dvV3rJtTsG9UehNFpped+EgxzlcnVNNoQ=; b=DhHHATsP1uj93RxWCVEfVXJTaU
	KpomxTo1WDB5SqSZoZgfQCdrrI3LSOOtrw5ylEaxyDuFvXXsHiZtCEViCc+ET6qQbHJExCvyni19W
	FXrtv9if9Vsvo6NQNFXD5Cam8bewsOqcarvcFLk2W97gz7/J1FECH/9HHx/s+Pwr1Isk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Tsi-00024i-3h;
	Mon, 07 Sep 2026 07:35:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3TsR-0001zM-5s
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b1N9xD6I1AtFBGROnAwiAj6AvG5a0JupI+PeFixM7Bw=; b=fAU3iqpYVLYqNjOln8k3i3HxN7
 e7K0bRh8yLasR0Tr7F81b9nsdChz2+XunVD8BavkeR1aK7/nItcLMt2xcUur7sW8NSrAJfIJY7fn2
 bzDPdx6iWEJCdtDV8G47bBATrVrcKT70oSt3X/Jfv887Eiljejgzw1EbpJLBdKWcDvIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b1N9xD6I1AtFBGROnAwiAj6AvG5a0JupI+PeFixM7Bw=; b=WcqrQt4zqBDe3c43h+r1ejvMvH
 h9GxUqWjbjbhUdNZLZ3lWrIPrOJWsDO5hI02W3BbQUR0ugnoBW6yUqZxJ8W0MJ8Om+3jMut57TSld
 mQInRcgT73BUiVcqovtc3C+Ifv4fnZxE0M4DiIk63lYMZk3S4FEHVrv+58fB/zQpHL5E=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3TsO-0003mR-Bo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 07:34:48 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so1961529a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788766482; x=1789371282; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b1N9xD6I1AtFBGROnAwiAj6AvG5a0JupI+PeFixM7Bw=;
 b=XM2uSPSamVG7j+A/NiU0NMvjXBxWCIkRQpl/lt336eMlyjKU3gxDJWcx6REqUFW5kD
 zz3AT/biNF7arJ9DjEE/jRDvUm5lktmF0C3u6LPzc1sZuLGShA3xTC162fj4X7T5sCCm
 yq3Y9C7JUdrQz6XR/Vxda8gnRO3dDkXZlwVoSeBfeXEwnLhgkhWLMW87oVDDlDbgKmst
 t6ukz1kmvtnzhE2niRPXDsFSs+4iqHP2lMkOa1XXXMbqBDRep9zw7XwLNj+IY93noggo
 RA4CveMtC39XuR7anGi3F82OHLoj0Z64gvYtx3CyF4xNiUEGdw5fD2yhAX37c9lpPfb0
 Y9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766482; x=1789371282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b1N9xD6I1AtFBGROnAwiAj6AvG5a0JupI+PeFixM7Bw=;
 b=hsjqCgUeeedAeIJuJIRkyFjYL8RWx8ONEGgSy15AdFMro5yhISnIpuV3hbVR9cjCBK
 xiqSN/J9qI+NSRqNZFa8g/W6CGdCz6hGDS6c/JL5f4mZzg7bFn3+YSdyN06iavzwrW2y
 J4dVPAMyONnl80hMUvk76IuzZJxl7IS+Cc288uiRkYfcLNQXWYCT5tXi1OPUh0GuUQ9T
 AalJQ1OnwZQmPUeGqBAtTXn3/PfOgzolCbPZREWr5nTDCD3zCkKuFTs44/w30tJXbhOK
 VH8Po09CtzZZHY4bZQxZB2Uqbwzk25DqMHjYbYZAIplY7KCcIcfFnM56w3/bDGbtMwoS
 1Evg==
X-Gm-Message-State: AFuF++mpj63Rpn2J8EymD7Fw8/znz89CkagsPHP5/kg42LUxQCBWOoo0
 VRMGfdGz/Z6uIspJmrVAUsaHqO0ueYaueKFv2TqCpDwzIJCuG9pvXZBR
X-Gm-Gg: AYBFou2hUBNHmnB1MQ6nHkPQXXi4Ruc0fxssNfWLSftCL6ZdHmjlq1m9P/CH1NFojsn
 gg2qh0BiyEneQLkOxOgrEa+g1Pi93S1UCgfvZS9i6tMSzXTUjIkQhCo5id9tmyraUGxsJPUG4Nd
 zr6hO2PpQhSrFxfQQeGMdTgD6TX3OqFr6gaXmlai8NYES0pE1ohjN1DVtof/DDZdsa8i/7dKpuL
 iVqn4bE/AOjO+/0UKw7ATOi6OQvtn+2B7f23qMimAZj/WrXmiOz6zFLYPO2U3rKTPcwQxyt/kXo
 MsXTGsRA146SzKxlDVjjNPVmbk34VjGKtASN6wyTIpyQgWfI56ksITqrvq3b9wmpQiFXjlIOL6j
 HXDXJz7zls6TGBvCUR/zerTBWGn5aMvsW0b+QWBO1AoCvxRS5q/I99imdr6AtbbG9xATVV3DuI1
 9aV2LHK2Zk3kGW4d2tGO2cFW2x3dGdkXx0oFY7SP0u9j1itZlmkfbdM1PNQp/OrxtTbKNAG72Wd
 SQPGEDGOGhP6VmdEdYvYuYTOA==
X-Received: by 2002:a17:90b:1c8b:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-39b26214502mr30069462a91.19.1788766482294; 
 Mon, 07 Sep 2026 00:34:42 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c397b1sm24931008a91.8.2026.09.07.00.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:34:41 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 15:34:34 +0800
Message-ID: <20260907073434.2349510-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <eecd3a49-d252-4d36-9e5a-44ac3eb02108@kernel.org>
References: <eecd3a49-d252-4d36-9e5a-44ac3eb02108@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3TsO-0003mR-Bo
Subject: Re: [f2fs-dev] [PATCH 06/14] f2fs: prepare mmap write faults for
 large folios
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 20:36:02 +0800, Chao Yu wrote:
> We only need to call f2fs_get_block_locked() for vmf->page?
>
> Hi Barry, could you please help to confirm this? Only vmf->page contain dirty
> data, rather than whole large folio contain dirty data?

Thanks for the review. Here is the write-fault path on current
mainline (mm/memory.c):

do_pte_missing()                          memory.c:4561
  -> do_fault()                           memory.c:5964
    -> do_shared_fault()                  memory.c:5914
      -> __do_fault() -> filemap_fault()  : fault in folio (may be 16KB)
      -> do_page_mkwrite(vmf, folio)      : page_mkwrite ONCE per folio (memory.c:5936)
         -> vma->vm_ops->page_mkwrite(vmf)  memory.c:3684
      -> finish_fault()                   memory.c:5617
         -> set_pte_range()               memory.c:5558
            if (write)
                entry = maybe_mkwrite(pte_mkdirty(entry), vma);   memory.c:5575
            set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);      memory.c:5586

So page_mkwrite is entered once per folio, and afterwards the PTEs of
all subpages are installed writable in one go - writes to other
subpages of the same folio will not fault again. That is why
f2fs_vm_page_mkwrite() preallocates/marks dirty_len rather than
handling vmf->page only.

I'll add a comment in f2fs_vm_page_mkwrite() in the next version to
make the point clear.

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
