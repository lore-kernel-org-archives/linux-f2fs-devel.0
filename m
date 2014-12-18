From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: merge two uchar variable in struct
 node_info to reduce memory cost
Date: Thu, 18 Dec 2014 17:07:43 +0900
Message-ID: <20141218080743.GA3335@lcm>
References: <000001d0184a$3f09d580$bd1d8080$@samsung.com>
 <CAN863PvqCJJ-m3NimjX7FKeY941rjSgmzupfPEMHm_qXgRBwfQ@mail.gmail.com>
 <004c01d01a96$2b5b3a80$8211af80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <004c01d01a96$2b5b3a80$8211af80$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Changman Lee' <cm224.lee@gmail.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Dec 18, 2014 at 02:29:51PM +0800, Chao Yu wrote:
> Hi Changman,
> 
> > -----Original Message-----
> > From: Changman Lee [mailto:cm224.lee@gmail.com]
> > Sent: Wednesday, December 17, 2014 11:09 PM
> > To: Chao Yu
> > Cc: Jaegeuk Kim; Changman Lee; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [PATCH v2] f2fs: merge two uchar variable in struct node_info to reduce
> > memory cost
> > 
> > Hi Yu,
> > 
> > This patch is effective only in 32 bit machine. In case of 64 bit
> > machine, nat_entry will be aligned in 8 bytes due to pointer variable
> > (i.e. struct list_head). So it can't get any benefit to reduce memory
> > usage. In the case of node_info, however, it will be gain in terms of
> > memory usage.
> > Hence, I think it's not correct for commit log to describe this patch.
> > 
> 
> Thanks for your review! :)
> 
> AFFIK, in 64 bit machine, size of struct nat_entry is 40 bytes before this patch
> apply, the reason is that our compiler will fill 3 bytes pads after flag as
> nid's offset should align to type size of nid, and then fill 7 byte pads after
> version as size of structure should align to 64 bits when the struct size is bigger
> than 64 bits.
> layout of struct nat_entry:
> |-----8 bytes-----|
> |list.next        |
> |list.prev        |
> |flag    |nid     |
> |ino     |blk_addr|
> |version          |
> After we apply this patch, size of struct nat_entry will be reduced to 32 bytes.
> Please correct me if I'm wrong.

Hi,

Sorry, you're right.
I miscalculated.

Thanks,

> 
> Anyway, I agreed that commit log should be uptodate.
> 
> Thanks,
> Yu
> 
> > Thanks,
> > 
> > Reviewed-by: Changman Lee <cm224.lee@samsung.com>
> > 
