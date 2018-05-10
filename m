From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] fs: f2fs: Adding new return type vm_fault_t
Date: Thu, 10 May 2018 21:02:05 +0530
Message-ID: <CAFqt6zZbci2FZPdTRCdhpTu0h=uguCnk+0q_602O6tz66oePxQ@mail.gmail.com>
References: <20180414201001.GA20256@jordon-HP-15-Notebook-PC>
 <86005c7f-136e-998d-e756-327b5df4d776@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jrdr.linux@gmail.com>) id 1fGnYG-0006dM-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 May 2018 15:32:16 +0000
Received: from mail-lf0-f67.google.com ([209.85.215.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fGnYD-00FPuw-6t
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 May 2018 15:32:16 +0000
Received: by mail-lf0-f67.google.com with SMTP id o123-v6so3556699lfe.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 May 2018 08:32:12 -0700 (PDT)
In-Reply-To: <86005c7f-136e-998d-e756-327b5df4d776@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net

On Mon, Apr 16, 2018 at 7:17 AM, Chao Yu <yuchao0@huawei.com> wrote:
> On 2018/4/15 4:10, Souptick Joarder wrote:
>> Use new return type vm_fault_t for page_mkwrite
>> and fault handler.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> Acked-by: Chao Yu <yuchao0@huawei.com>
>

Chao, If no further comment, we would like to get this patch
queued for 4.18.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
