From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: [PATCH] fs: f2fs: Adding new return type vm_fault_t
Date: Thu, 10 May 2018 22:42:04 +0530
Message-ID: <CAFqt6zbDNUo-rzWeLES_Z-TmhL9Yy-Qs_RbsCjn0zvhkM-rEOw@mail.gmail.com>
References: <20180414201001.GA20256@jordon-HP-15-Notebook-PC>
 <86005c7f-136e-998d-e756-327b5df4d776@huawei.com>
 <CAFqt6zZbci2FZPdTRCdhpTu0h=uguCnk+0q_602O6tz66oePxQ@mail.gmail.com>
 <20180510162305.GA49708@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jrdr.linux@gmail.com>) id 1fGp70-0002SD-0Y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 May 2018 17:12:14 +0000
Received: from mail-lf0-f65.google.com ([209.85.215.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fGp6y-00FZMs-84
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 May 2018 17:12:13 +0000
Received: by mail-lf0-f65.google.com with SMTP id h197-v6so3988906lfg.11
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 May 2018 10:12:12 -0700 (PDT)
In-Reply-To: <20180510162305.GA49708@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net

On Thu, May 10, 2018 at 9:53 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> On 05/10, Souptick Joarder wrote:
>> On Mon, Apr 16, 2018 at 7:17 AM, Chao Yu <yuchao0@huawei.com> wrote:
>> > On 2018/4/15 4:10, Souptick Joarder wrote:
>> >> Use new return type vm_fault_t for page_mkwrite
>> >> and fault handler.
>> >>
>> >> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> >
>> > Acked-by: Chao Yu <yuchao0@huawei.com>
>> >
>>
>> Chao, If no further comment, we would like to get this patch
>> queued for 4.18.
>
> Hi Souptick,
>
> Is this one of your patch series?
> I already queued it towards 4.18:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=f8fcb679cfbeb2076c547364929182babdd69a50
>
> Thanks,

Thanks.
Not exactly part of patch series. But we are trickling patches to
individual maintainers of each drivers/ filesystems to merge it in
linus tree.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
