Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFB6C87FCB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Jul 2025 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICtQUKgdgD9ZZVeoo+vn7QtG3W/GXVt4HrUX7rFmdP0=; b=cGlnC8VlX70qNTgEmk9u9gwYPx
	eAlA+W4Utu1QCgLEIL4YJ51J4InKzF0fFsCyfFP19fx8n53lopmXeN3ph8H3h67dKkaf96KgFzQ+S
	8jCPfNZuXvwla81yT20RdYeXds/zcbjo/04yWF8IJGgrnrZPlOkk4mrv2Sqg8dkBKlPM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uhJ8U-0006Xj-J3;
	Thu, 31 Jul 2025 02:35:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uhJ8T-0006Xc-E5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 02:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wkoDWe4SMARZhf5/I7XRIEg5iCCHe5ATVMX3EQKal0=; b=EfKpOMziOYcdXtXFQOCqxXTTeR
 5sNH6W58P/q6aXw7JPtVbRj/xUMBktlXJCjARVc0eqsOdFBKnj+aSejdKQCV3x+owWLFp+x3wOovp
 RtqK7clW3a9e9QrxXtkRb+vJWQhewSNgFbZ0iQLldoyuwBLTjYpYvv+q3Ez0LtDvNA2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2wkoDWe4SMARZhf5/I7XRIEg5iCCHe5ATVMX3EQKal0=; b=ACxvr7M23GWad0+DHIdXd/ym9T
 xC9TWgeOlf1mlgl/APo/9YJAgma/+KosQXM1EbkwVdG1c+hmJJoBXwqt3MGzkue8ZL4AgQeIJoUW4
 jiR/RyvNu1aICjscVP8v4/hgM698cqDlcImi9HRbk9yWRPWbYcbbhk1tR31BsrpJZei4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uhJ8R-0006ZD-VI for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 02:35:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5305D60051;
 Thu, 31 Jul 2025 02:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B73C4CEE7;
 Thu, 31 Jul 2025 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753929305;
 bh=UHqwiB2HFxlaVsf0AnH8LVGWkwp0vtIC3mHZAtUnuAQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=LC2sFl310tDMoPB/5IHJmrjNm9jxZ0JJYBlIAqQiiD8E/3Wdj/PReN6zVq5oqGbyt
 LVskMebEmxNu1hHyycf+bDPL/vQhk/nNVmmuH+c2W0O9VOVgjeO2EZ4iNYgQ34Foep
 Evro3GGlU6VTtrGbg1/Y3vLT0widZcA0iIb9pNDmkxKr0/ehb6FlJxmSJ1DvFY6PTA
 XidDL+wDmPuQrataEN77hTaUoHWYq+hdtnkIxFt4BtdZI9p9BX1UIMkNZMNYryqWiZ
 IdIKNWvSL5wtINm2QcPAr038CUel2I98ydYQ/Jwn6CPgPds1kqyOdm7fJxeSFUxZsx
 m5LCiu8bJZ+DA==
Message-ID: <68c061ad-cbb7-44e8-a905-c13b9ec81c62@kernel.org>
Date: Thu, 31 Jul 2025 10:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>, hanqi <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
Content-Language: en-US
In-Reply-To: <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
X-Headers-End: 1uhJ8R-0006ZD-VI
Subject: Re: [f2fs-dev] [PATCH] f2fs: f2fs supports uncached buffered I/O
 read
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/30/25 23:20, Jens Axboe wrote:
> On 7/28/25 2:28 AM, hanqi wrote:
>> ? 2025/7/28 16:07, Chao Yu ??:
>>> On 7/28/25 16:03, hanqi wrote:
>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>
>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>> as Jen mentioned in below path, right?
>>>>>
>>>>> soft-irq
>>>>> - folio_end_writeback()
>>>>>    - filemap_end_dropbehind_write()
>>>>>     - filemap_end_dropbehind()
>>>>>      - folio_unmap_invalidate()
>>>>>       - lock i_lock
>>>>>
>>>>> Thanks,
>>>> That's how I understand it.
>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>> you can walk around for write path in this patch.
>>>
>>> Thanks,
>>
>> I think the read and write paths can be submitted separately.
>> Currently, uncached buffered I/O write requires setting the
>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>> f2fs, this is done in the following path:
>>
>> - write_begin
>>  - f2fs_write_begin
>>   - __filemap_get_folio
>>   As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>> issue shouldn't occur.
> 
> It won't cause an issue, but it also won't work in the sense that the
> intent is that if the file system doesn't support DONTCACHE, it would
> get errored at submission time. Your approach would just ignore the flag
> for writes, rather than return -EOPNOTSUPP as would be expected.

Jens,

Do you mean like what we have done in kiocb_set_rw_flags()?

	if (flags & RWF_DONTCACHE) {
		/* file system must support it */
		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
			return -EOPNOTSUPP;
...
	}

IIUC, it's better to have this in original patch, let me know if I'm
missing something.

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b8d24097b7a..7f09cad6b6d7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5185,6 +5185,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}

+	if (iocb->ki_flags & IOCB_DONTCACHE) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!f2fs_is_compress_backend_ready(inode)) {
 		ret = -EOPNOTSUPP;
 		goto out;
-- 

Thanks,

> 
> You could potentially make it work just on the read side by having the
> f2fs write submit side check DONTCACHE on the write side and error them
> out.
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
