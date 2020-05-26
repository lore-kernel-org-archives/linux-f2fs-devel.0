Return-Path: <SRS0=7Dm8=7I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8D9C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2020 02:20:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA07207CB;
	Tue, 26 May 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="APZvfDwr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Q/FEtUr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA07207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jdPD6-0007sx-FG; Tue, 26 May 2020 02:20:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jdPD0-0007sh-Mf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 May 2020 02:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Aw2yjqNCPWXA60KNqCX5Ot+VEjJ4UqmOXTC90kKt30=; b=APZvfDwrXZp6so82pNHcCLLgz0
 vbw675x0QJSUIDTSnyfkW3tRcMBmD+EpitpGXm1NO4mvqSQ4gi2/b0jE946XfyCMsRlg8sBZ0NK+b
 SNK5SH61WNllxn9jEIzecUYIIfa/mLMXN8/yfWhxSbgQqGDsRHqUaW4bxPNt04Nq/hIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Aw2yjqNCPWXA60KNqCX5Ot+VEjJ4UqmOXTC90kKt30=; b=Q/FEtUr26rNShNEiu67w/eOSET
 qxpkjg17Qi5CBFYFo9BXZeRwFupp8EhapNrkrzQAz2EvdDIuZmLn8moRI22P1wa+PmqGziSRDaSZO
 5KRsUOHAElYEQ8ou1WPIgAhWPbDUAtHwLU0XkHqpgY7HmBZFa0kWmlLWsYxUL11a/2rg=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jdPCy-00D2EB-Jg
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 May 2020 02:20:50 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 098E357682F8C0CF7F8B;
 Tue, 26 May 2020 10:20:39 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 May
 2020 10:20:38 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200526015917.GB207949@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <9a09da49-9b3d-68c3-f47f-40bb7e4309b8@huawei.com>
Date: Tue, 26 May 2020 10:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200526015917.GB207949@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jdPCy-00D2EB-Jg
Subject: Re: [f2fs-dev] Discard issue
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
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

On 2020/5/26 9:59, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I'm hitting segment.c:1065 when running longer fsstress (1000s) with error

(1000s) do you mean time in single round or total time of multi rounds?

> injection. Do you have any issue from your side?

I haven't hit that before, in my test, in single round, fsstress won't last long
time (normally about 10s+ for each round).

Below is por_fsstress() implementation in my code base:

por_fsstress()
{
        _fs_opts

        while true; do
                ltp/fsstress -x "echo 3 > /proc/sys/vm/drop_caches" -X 10 -r -f fsync=8 -f sync=0 -f write=4 -f dwrite=2 -f truncate=6 -f allocsp=0 -f bulkstat=0 -f bulkstat1=0 -f freesp=0 -f zero=1 -f collapse=1 -f insert=1 -f resvsp=0 -f unresvsp=0 -S t -p 20 -n 200000 -d $TESTDIR/test &
                sleep 10
                src/godown $TESTDIR
                killall fsstress
                sleep 5
                umount $TESTDIR
                if [ $? -ne 0 ]; then
                        for i in `seq 1 50`
                        do
                                umount $TESTDIR
                                if [ $? -eq 0]; then
                                        break
                                fi
                                sleep 5
                        done
                fi
                echo 3 > /proc/sys/vm/drop_caches
                _fsck
                _mount f2fs
                rm $TESTDIR/testfile
                touch $TESTDIR/testfile
                umount $TESTDIR
                _fsck
                _mount f2fs
                _rm_50
        done
}

Did you update this code?

Could you share more test configuration, like mkfs option, device size, mount option,
new por_fsstress() implementation if it exists? I can try to reproduce this issue
in my env.

Thanks,

> 
> Thanks,
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
