From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Date: Wed, 16 May 2018 13:02:02 +0530
Message-ID: <20180516073202.GB6293@codeaurora.org>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
 <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
 <20180515075747.GA6293@codeaurora.org>
 <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67bd2926-6851-0544-c24a-85dfa72aa70f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 16, 2018 at 02:48:42PM +0800, Chao Yu wrote:
> > 
> > Thanks, I thought about it too but then I checked that XFS shutdown ioctl is
> > not taking any lock for this ioctl. Hence, I followed the same in F2FS.
> > Do you know why XFS is not taking any lock? 
> 
> I don't know. :(

No problem :)

> 
> > Is it really needed in shutdown ioctl?
> 
> IMO, yes, we should keep freeze and remount be aware of the shutdown operation.

Thanks for your inputs. I will send the updated patch set.

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
